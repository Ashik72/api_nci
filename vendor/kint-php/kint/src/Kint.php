<?php

class Kint
{
    /**
     * @var mixed Kint mode
     *
     * false: Disabled
     * true: Enabled, default mode selection
     * string: Manual mode selection
     */
    public static $enabled_mode = true;

    /**
     * Default mode.
     *
     * @var string
     */
    public static $mode_default = self::MODE_RICH;

    /**
     * Default mode in CLI with cli_detection on.
     *
     * @var string
     */
    public static $mode_default_cli = self::MODE_CLI;

    /**
     * @var bool Return output instead of echoing
     */
    public static $return;

    /**
     * @var string format of the link to the source file in trace entries.
     *
     * Use %f for file path, %l for line number.
     *
     * [!] EXAMPLE (works with for phpStorm and RemoteCall Plugin):
     *
     * Kint::$file_link_format = 'http://localhost:8091/?message=%f:%l';
     */
    public static $file_link_format = '';

    /**
     * @var bool whether to display where kint was called from
     */
    public static $display_called_from = true;

    /**
     * @var array base directories of your application that will be displayed instead of the full path.
     *
     * Keys are paths, values are replacement strings
     *
     * [!] EXAMPLE (for Kohana framework):
     *
     * Kint::$app_root_dirs = array(
     *      APPPATH => 'APPPATH',
     *      SYSPATH => 'SYSPATH',
     *      MODPATH => 'MODPATH',
     *      DOCROOT => 'DOCROOT',
     * );
     *
     * [!] EXAMPLE #2 (for a semi-universal approach)
     *
     * Kint::$app_root_dirs = array(
     *      realpath( __DIR__ . '/../../..' ) => 'ROOT', // go up as many levels as needed
     * );
     */
    public static $app_root_dirs = array();

    /**
     * @var int max array/object levels to go deep, if zero no limits are applied
     */
    public static $max_depth = 7;

    /**
     * @var bool expand all trees by default for rich view
     */
    public static $expanded = false;

    /**
     * @var bool enable detection when Kint is command line.
     *
     * Formats output with whitespace only; does not HTML-escape it
     */
    public static $cli_detection = true;

    /**
     * @var array Kint aliases. Add debug functions in Kint wrappers here to fix modifiers and backtraces
     */
    public static $aliases = array(
        array('Kint', 'dump'),
        array('Kint', 'trace'),
    );

    /**
     * @var array Kint_Renderer descendants. Add to array to extend.
     */
    public static $renderers = array(
        self::MODE_RICH => 'Kint_Renderer_Rich',
        self::MODE_PLAIN => 'Kint_Renderer_Plain',
        self::MODE_TEXT => 'Kint_Renderer_Text',
        self::MODE_CLI => 'Kint_Renderer_Cli',
    );

    const MODE_RICH = 'r';
    const MODE_TEXT = 't';
    const MODE_CLI = 'c';
    const MODE_PLAIN = 'p';

    public static $plugins = array(
        'Kint_Parser_Base64',
        'Kint_Parser_Binary',
        'Kint_Parser_Blacklist',
        'Kint_Parser_ClassMethods',
        'Kint_Parser_ClassStatics',
        'Kint_Parser_Closure',
        'Kint_Parser_Color',
        'Kint_Parser_DOMIterator',
        'Kint_Parser_DOMNode',
        'Kint_Parser_FsPath',
        'Kint_Parser_Iterator',
        'Kint_Parser_Json',
        'Kint_Parser_Microtime',
        'Kint_Parser_Serialize',
        'Kint_Parser_SimpleXMLElement',
        'Kint_Parser_SplFileInfo',
        'Kint_Parser_SplObjectStorage',
        'Kint_Parser_Stream',
        'Kint_Parser_Table',
        'Kint_Parser_Timestamp',
        'Kint_Parser_ToString',
        'Kint_Parser_Trace',
        'Kint_Parser_Xml',
    );

    private static $plugin_pool = array();

    /**
     * Stashes or sets all settings at once.
     *
     * @param array|null $settings Array of all settings to be set or null to set none
     *
     * @return array Current settings
     */
    public static function settings(array $settings = null)
    {
        static $keys = array(
            'aliases',
            'app_root_dirs',
            'cli_detection',
            'display_called_from',
            'enabled_mode',
            'expanded',
            'file_link_format',
            'max_depth',
            'mode_default',
            'mode_default_cli',
            'renderers',
            'return',
            'plugins',
        );

        $out = array();

        foreach ($keys as $key) {
            $out[$key] = self::$$key;
        }

        if ($settings !== null) {
            $in = array_intersect_key($settings, $out);
            foreach ($in as $key => $val) {
                self::$$key = $val;
            }
        }

        return $out;
    }

    /**
     * Prints a debug backtrace, same as Kint::dump(1).
     *
     * @param array $trace [OPTIONAL] you can pass your own trace, otherwise, `debug_backtrace` will be called
     *
     * @return mixed
     */
    public static function trace($trace = null)
    {
        if ($trace === null) {
            if (KINT_PHP525) {
                $trace = debug_backtrace(true);
            } else {
                $trace = debug_backtrace();
            }
        }

        return self::dump($trace);
    }

    /**
     * Dump information about variables, accepts any number of parameters, supports modifiers:.
     *
     *  clean up any output before kint and place the dump at the top of page:
     *   - Kint::dump()
     *  *****
     *  expand all nodes on display:
     *   ! Kint::dump()
     *  *****
     *  dump variables disregarding their depth:
     *   + Kint::dump()
     *  *****
     *  return output instead of displaying it:
     *
     *   @ Kint::dump()
     *  *****
     *  force output as plain text
     *   ~ Kint::dump()
     *
     * Modifiers are supported by all dump wrapper functions, including Kint::trace(). Space is optional.
     *
     * @param mixed $data
     *
     * @return void|string
     */
    public static function dump($data = null)
    {
        if (!self::$enabled_mode) {
            return 0;
        }

        $stash = self::settings();
        $num_args = func_num_args();

        list($params, $modifiers, $callee, $caller, $minitrace) = self::getCalleeInfo(
            defined('DEBUG_BACKTRACE_IGNORE_ARGS')
                ? debug_backtrace(DEBUG_BACKTRACE_IGNORE_ARGS)
                : debug_backtrace(),
            $num_args
        );

        // set mode for current run
        if (self::$enabled_mode === true) {
            self::$enabled_mode = self::$mode_default;
            if (PHP_SAPI === 'cli' && self::$cli_detection === true) {
                self::$enabled_mode = self::$mode_default_cli;
            }
        }

        if (in_array('~', $modifiers)) {
            self::$enabled_mode = self::MODE_TEXT;
        }

        if (!array_key_exists(self::$enabled_mode, self::$renderers)) {
            $renderer = self::$renderers[self::MODE_PLAIN];
        } else {
            $renderer = self::$renderers[self::$enabled_mode];
        }

        // process modifiers: @, +, ! and -
        if (in_array('-', $modifiers)) {
            while (ob_get_level()) {
                ob_end_clean();
            }
        }
        if (in_array('!', $modifiers)) {
            self::$expanded = true;
        }
        if (in_array('+', $modifiers)) {
            self::$max_depth = false;
        }
        if (in_array('@', $modifiers)) {
            self::$return = true;
        }

        $renderer = new $renderer(array(
            'num_args' => $num_args,
            'params' => $params,
            'modifiers' => $modifiers,
            'callee' => $callee,
            'caller' => $caller,
            'minitrace' => $minitrace,
            'settings' => self::settings(),
            'stash' => $stash,
        ));

        $output = call_user_func(array($renderer, 'preRender'));

        $parser = new Kint_Parser(self::$max_depth, empty($caller['class']) ? null : $caller['class']);

        foreach (self::$plugins as $plugin) {
            if ($plugin instanceof Kint_Parser_Plugin) {
                $parser->addPlugin($plugin);
            } elseif (is_string($plugin) && is_subclass_of($plugin, 'Kint_Parser_Plugin')) {
                if (!isset(self::$plugin_pool[$plugin])) {
                    $p = new $plugin();
                    self::$plugin_pool[$plugin] = $p;
                }
                $parser->addPlugin(self::$plugin_pool[$plugin]);
            }
        }

        // Kint::dump(1) shorthand
        if ((!isset($params[0]['name']) || $params[0]['name'] == '1') && $num_args === 1 && $data === 1) {
            if (KINT_PHP525) {
                $data = debug_backtrace(true);
            } else {
                $data = debug_backtrace();
            }

            $trace = array();

            // No need to normalize as we've already called it through getCalleeInfo at this point
            foreach ($data as $index => $frame) {
                if (Kint_Parser_Trace::frameIsListed($frame, self::$aliases)) {
                    $trace = array();
                }

                $trace[] = $frame;
            }

            $lastframe = array_shift($trace);
            $tracename = $lastframe['function'].'(1)';
            if (isset($lastframe['class'], $lastframe['type'])) {
                $tracename = $lastframe['class'].$lastframe['type'].$tracename;
            }
            $tracebase = Kint_Object::blank($tracename, 'debug_backtrace()');

            if (empty($trace)) {
                $output .= call_user_func(array($renderer, 'render'), $tracebase->transplant(new Kint_Object_Trace()));
            } else {
                $output .= call_user_func(array($renderer, 'render'), $parser->parse($trace, $tracebase));
            }
        } else {
            $data = func_get_args();
            if ($data === array()) {
                $output .= call_user_func(array($renderer, 'render'), new Kint_Object_Nothing());
            }

            static $blacklist = array('null', 'true', 'false', 'array(...)', 'array()', '"..."', 'b"..."', '[...]', '[]', '(...)', '()');

            foreach ($data as $i => $argument) {
                if (!isset($params[$i]['name']) || is_numeric($params[$i]['name']) || in_array(str_replace("'", '"', strtolower($params[$i]['name'])), $blacklist, true)) {
                    $name = null;
                } else {
                    $name = $params[$i]['name'];
                }

                if (isset($params[$i]['path'])) {
                    $access_path = $params[$i]['path'];

                    if (!empty($params[$i]['expression'])) {
                        $access_path = '('.$access_path.')';
                    }
                } else {
                    $access_path = '$'.$i;
                }

                $output .= call_user_func(
                    array($renderer, 'render'),
                    $parser->parse($argument, Kint_Object::blank($name, $access_path))
                );
            }
        }

        $output .= call_user_func(array($renderer, 'postRender'));

        if (self::$return) {
            self::settings($stash);

            return $output;
        }

        self::settings($stash);
        echo $output;

        return 0;
    }

    /**
     * generic path display callback, can be configured in app_root_dirs; purpose is
     * to show relevant path info and hide as much of the path as possible.
     *
     * @param string $file
     *
     * @return string
     */
    public static function shortenPath($file)
    {
        $file = str_replace('\\', '/', $file);
        $shortenedName = $file;
        $replaced = false;
        if (is_array(self::$app_root_dirs)) {
            foreach (self::$app_root_dirs as $path => $replaceString) {
                if (empty($path)) {
                    continue;
                }

                $path = str_replace('\\', '/', $path);

                if (strpos($file, $path) === 0) {
                    $shortenedName = $replaceString.substr($file, strlen($path));
                    $replaced = true;
                    break;
                }
            }
        }

        // fallback to find common path with Kint dir
        if (!$replaced) {
            $pathParts = explode('/', str_replace('\\', '/', KINT_DIR));
            $fileParts = explode('/', $file);
            $i = 0;
            foreach ($fileParts as $i => $filePart) {
                if (!isset($pathParts[$i]) || $pathParts[$i] !== $filePart) {
                    break;
                }
            }

            $shortenedName = ($i ? '.../' : '').implode('/', array_slice($fileParts, $i));
        }

        return $shortenedName;
    }

    public static function getIdeLink($file, $line)
    {
        return str_replace(array('%f', '%l'), array($file, $line), self::$file_link_format);
    }

    /**
     * returns parameter names that the function was passed, as well as any predefined symbols before function
     * call (modifiers).
     *
     * @param array $trace
     *
     * @return array($params, $modifiers, $callee, $caller, $miniTrace)
     */
    private static function getCalleeInfo($trace, $num_params)
    {
        Kint_Parser_Trace::normalizeAliases(self::$aliases);
        $miniTrace = array();

        foreach ($trace as $index => $frame) {
            if (Kint_Parser_Trace::frameIsListed($frame, self::$aliases)) {
                $miniTrace = array();
            }

            if (!Kint_Parser_Trace::frameIsListed($frame, array('spl_autoload_call'))) {
                $miniTrace[] = $frame;
            }
        }

        $callee = reset($miniTrace);
        $caller = next($miniTrace);
        if (!$callee) {
            $callee = null;
        }
        if (!$caller) {
            $caller = null;
        }

        unset($miniTrace[0]);

        foreach ($miniTrace as $index => &$frame) {
            if (!isset($frame['file'], $frame['line'])) {
                unset($miniTrace[$index]);
            } else {
                unset($frame['object'], $frame['args']);
            }
        }

        $miniTrace = array_values($miniTrace);

        if (!isset($callee['file'], $callee['line']) || !is_readable($callee['file'])) {
            return array(null, array(), $callee, $caller, $miniTrace);
        }

        // open the file and read it up to the position where the function call expression ended
        if (empty($callee['class'])) {
            $callfunc = $callee['function'];
        } else {
            $callfunc = array($callee['class'], $callee['function']);
        }

        $calls = Kint_SourceParser::getFunctionCalls(
            file_get_contents($callee['file']),
            $callee['line'],
            $callfunc
        );

        $return = array(null, array(), $callee, $caller, $miniTrace);

        foreach ($calls as $call) {
            $is_unpack = false;

            // Handle argument unpacking as a last resort
            if (KINT_PHP56) {
                foreach ($call['parameters'] as $i => &$param) {
                    if (strpos($param['name'], '...') === 0) {
                        if ($i === count($call['parameters']) - 1) {
                            for ($j = 1; $j + $i < $num_params; ++$j) {
                                $call['parameters'][] = array(
                                    'name' => 'array_values('.substr($param['name'], 3).')['.$j.']',
                                    'path' => 'array_values('.substr($param['path'], 3).')['.$j.']',
                                    'expression' => false,
                                );
                            }

                            $param['name'] = 'reset('.substr($param['name'], 3).')';
                            $param['path'] = 'reset('.substr($param['path'], 3).')';
                            $param['expression'] = false;
                        } else {
                            $call['parameters'] = array_slice($call['parameters'], 0, $i);
                        }

                        $is_unpack = true;
                        break;
                    }
                }
            }

            if ($is_unpack || count($call['parameters']) === $num_params) {
                if ($return[0] === null) {
                    $return = array($call['parameters'], $call['modifiers'], $callee, $caller, $miniTrace);
                } else {
                    // If we have multiple calls on the same line with the same amount of arguments,
                    // we can't be sure which it is so just return null and let them figure it out
                    return array(null, array(), $callee, $caller, $miniTrace);
                }
            }
        }

        return $return;
    }

    public static function composerGetExtras($key = 'kint')
    {
        $extras = array();

        if (!KINT_PHP53) {
            return $extras;
        }

        $folder = KINT_DIR.'/vendor';

        for ($i = 0; $i < 4; ++$i) {
            $installed = $folder.'/composer/installed.json';

            if (file_exists($installed) && is_readable($installed)) {
                $packages = json_decode(file_get_contents($installed), true);

                foreach ($packages as $package) {
                    if (isset($package['extra'][$key]) && is_array($package['extra'][$key])) {
                        $extras = array_replace($extras, $package['extra'][$key]);
                    }
                }

                $folder = dirname($folder);

                if (file_exists($folder.'/composer.json') && is_readable($folder.'/composer.json')) {
                    $composer = json_decode(file_get_contents($folder.'/composer.json'), true);

                    if (isset($composer['extra'][$key]) && is_array($composer['extra'][$key])) {
                        $extras = array_replace($extras, $composer['extra'][$key]);
                    }
                }

                break;
            } else {
                $folder = dirname($folder);
            }
        }

        return $extras;
    }

    public static function composerGetDisableHelperFunctions()
    {
        $extras = self::composerGetExtras();

        return !empty($extras['disable-helper-functions']);
    }
}
