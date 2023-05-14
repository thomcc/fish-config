# complete -c x -n "__fish_use_subcommand" -s h -l help -d 'Prints help information'
# complete -c x -n "__fish_use_subcommand" -a "build" -d 'Compile either the compiler or libraries'
# complete -c x -n "__fish_use_subcommand" -a "check" -d 'Compile either the compiler or libraries, using cargo check'
# complete -c x -n "__fish_use_subcommand" -a "clippy" -d 'Run clippy (uses rustup/cargo-installed clippy binary)'
# complete -c x -n "__fish_use_subcommand" -a "fix" -d 'Run Cargo fix'
# complete -c x -n "__fish_use_subcommand" -a "fmt" -d 'Run rustfmt'

# complete -c x -n '__fish_use_subcommand' -f -a test        -d 'Build and run some test suites'
# complete -c x -n '__fish_use_subcommand' -f -a bench       -d 'Build and run some benchmarks'
# complete -c x -n '__fish_use_subcommand' -f -a doc         -d 'Build documentation'
# complete -c x -n '__fish_use_subcommand' -f -a clean       -d 'Clean out build directories'
# complete -c x -n '__fish_use_subcommand' -f -a dist        -d 'Build distribution artifacts'
# complete -c x -n '__fish_use_subcommand' -f -a install     -d 'Install distribution artifacts'
# complete -c x -n '__fish_use_subcommand' -f -a run         -d 'Run tools contained in this repository'
# complete -c x -n '__fish_use_subcommand' -f -a setup       -d 'Create a config.toml (making it easier to use `x.py` itself)'

# complete -c x -n "__fish_use_subcommand" -f -a "test" -d 'Tests that a book\'s Rust code samples compile'
# complete -c x -n "__fish_use_subcommand" -f -a "clean" -d 'Deletes a built book'
# complete -c x -n "__fish_use_subcommand" -f -a "completions" -d 'Generate shell completions for your shell to stdout'
# complete -c x -n "__fish_use_subcommand" -f -a "watch" -d 'Watches a book\'s files and rebuilds it on changes'
# complete -c x -n "__fish_use_subcommand" -f -a "serve" -d 'Serves a book at http://localhost:3000, and rebuilds it on changes'
# complete -c x -n "__fish_use_subcommand" -f -a "help" -d 'Prints this message or the help of the given subcommand(s)'

# complete -c mdbook -n "__fish_use_subcommand" -s V -l version -d 'Prints version information'
# complete -c mdbook -n "__fish_use_subcommand" -f -a "init" -d 'Creates the boilerplate structure and files for a new book'
# complete -c mdbook -n "__fish_use_subcommand" -f -a "build" -d 'Builds a book from its markdown files'
# complete -c mdbook -n "__fish_use_subcommand" -f -a "test" -d 'Tests that a book\'s Rust code samples compile'
# complete -c mdbook -n "__fish_use_subcommand" -f -a "clean" -d 'Deletes a built book'
# complete -c mdbook -n "__fish_use_subcommand" -f -a "completions" -d 'Generate shell completions for your shell to stdout'
# complete -c mdbook -n "__fish_use_subcommand" -f -a "watch" -d 'Watches a book\'s files and rebuilds it on changes'
# complete -c mdbook -n "__fish_use_subcommand" -f -a "serve" -d 'Serves a book at http://localhost:3000, and rebuilds it on changes'
# complete -c mdbook -n "__fish_use_subcommand" -f -a "help" -d 'Prints this message or the help of the given subcommand(s)'
# complete -c mdbook -n "__fish_seen_subcommand_from init" -l title -d 'Sets the book title'
# complete -c mdbook -n "__fish_seen_subcommand_from init" -l ignore -d 'Creates a VCS ignore file (i.e. .gitignore)' -r -f -a "none git"
# complete -c mdbook -n "__fish_seen_subcommand_from init" -l theme -d 'Copies the default theme into your source folder'
# complete -c mdbook -n "__fish_seen_subcommand_from init" -l force -d 'Skips confirmation prompts'
# complete -c mdbook -n "__fish_seen_subcommand_from init" -s h -l help -d 'Prints help information'
# complete -c mdbook -n "__fish_seen_subcommand_from init" -s V -l version -d 'Prints version information'
# complete -c mdbook -n "__fish_seen_subcommand_from build" -s d -l dest-dir -d 'Output directory for the book{n}Relative paths are interpreted relative to the book\'s root directory.{n}If omitted, mdBook uses build.build-dir from book.toml or defaults to `./book`.'
# complete -c mdbook -n "__fish_seen_subcommand_from build" -s o -l open -d 'Opens the compiled book in a web browser'
# complete -c mdbook -n "__fish_seen_subcommand_from build" -s h -l help -d 'Prints help information'
# complete -c mdbook -n "__fish_seen_subcommand_from build" -s V -l version -d 'Prints version information'
# complete -c mdbook -n "__fish_seen_subcommand_from test" -s d -l dest-dir -d 'Output directory for the book{n}Relative paths are interpreted relative to the book\'s root directory.{n}If omitted, mdBook uses build.build-dir from book.toml or defaults to `./book`.'
# complete -c mdbook -n "__fish_seen_subcommand_from test" -s L -l library-path -d 'A comma-separated list of directories to add to {n}the crate search path when building tests'
# complete -c mdbook -n "__fish_seen_subcommand_from test" -s h -l help -d 'Prints help information'
# complete -c mdbook -n "__fish_seen_subcommand_from test" -s V -l version -d 'Prints version information'
# complete -c mdbook -n "__fish_seen_subcommand_from clean" -s d -l dest-dir -d 'Output directory for the book{n}Relative paths are interpreted relative to the book\'s root directory.{n}Running this command deletes this directory.{n}If omitted, mdBook uses build.build-dir from book.toml or defaults to `./book`.'
# complete -c mdbook -n "__fish_seen_subcommand_from clean" -s h -l help -d 'Prints help information'
# complete -c mdbook -n "__fish_seen_subcommand_from clean" -s V -l version -d 'Prints version information'
# complete -c mdbook -n "__fish_seen_subcommand_from completions" -s h -l help -d 'Prints help information'
# complete -c mdbook -n "__fish_seen_subcommand_from completions" -s V -l version -d 'Prints version information'
# complete -c mdbook -n "__fish_seen_subcommand_from watch" -s d -l dest-dir -d 'Output directory for the book{n}Relative paths are interpreted relative to the book\'s root directory.{n}If omitted, mdBook uses build.build-dir from book.toml or defaults to `./book`.'
# complete -c mdbook -n "__fish_seen_subcommand_from watch" -s o -l open -d 'Open the compiled book in a web browser'
# complete -c mdbook -n "__fish_seen_subcommand_from watch" -s h -l help -d 'Prints help information'
# complete -c mdbook -n "__fish_seen_subcommand_from watch" -s V -l version -d 'Prints version information'
# complete -c mdbook -n "__fish_seen_subcommand_from serve" -s d -l dest-dir -d 'Output directory for the book{n}Relative paths are interpreted relative to the book\'s root directory.{n}If omitted, mdBook uses build.build-dir from book.toml or defaults to `./book`.'
# complete -c mdbook -n "__fish_seen_subcommand_from serve" -s n -l hostname -d 'Hostname to listen on for HTTP connections'
# complete -c mdbook -n "__fish_seen_subcommand_from serve" -s p -l port -d 'Port to use for HTTP connections'
# complete -c mdbook -n "__fish_seen_subcommand_from serve" -s o -l open -d 'Opens the book server in a web browser'
# complete -c mdbook -n "__fish_seen_subcommand_from serve" -s h -l help -d 'Prints help information'
# complete -c mdbook -n "__fish_seen_subcommand_from serve" -s V -l version -d 'Prints version information'
# complete -c mdbook -n "__fish_seen_subcommand_from help" -s h -l help -d 'Prints help information'
# complete -c mdbook -n "__fish_seen_subcommand_from help" -s V -l version -d 'Prints version information'
# Available paths:
#     ./x.py build compiler/rustc
#     ./x.py build compiler/rustc_codegen_cranelift
#     ./x.py build compiler/rustc_codegen_gcc
#     ./x.py build library/alloc
#     ./x.py build library/core
#     ./x.py build library/panic_abort
#     ./x.py build library/panic_unwind
#     ./x.py build library/proc_macro
#     ./x.py build library/std
#     ./x.py build library/test
#     ./x.py build library/unwind
#     ./x.py build library/rtstartup
#     ./x.py build src/librustdoc
#     ./x.py build src/llvm
#     ./x.py build src/llvm-project
#     ./x.py build src/llvm-project/compiler-rt
#     ./x.py build src/llvm-project/compiler-rt/lib/crt
#     ./x.py build src/llvm-project/lld
#     ./x.py build src/llvm-project/llvm
#     ./x.py build src/sanitizers
#     ./x.py build src/tools/build-manifest
#     ./x.py build src/tools/cargo
#     ./x.py build src/tools/cargotest
#     ./x.py build src/tools/clippy
#     ./x.py build src/tools/compiletest
#     ./x.py build src/tools/error_index_generator
#     ./x.py build src/tools/linkchecker
#     ./x.py build src/tools/lld
#     ./x.py build src/tools/miri
#     ./x.py build src/tools/miri/cargo-miri
#     ./x.py build src/tools/remote-test-client
#     ./x.py build src/tools/remote-test-server
#     ./x.py build src/tools/rls
#     ./x.py build src/tools/rust-analyzer/crates/rust-analyzer
#     ./x.py build src/tools/rust-demangler
#     ./x.py build src/tools/rust-installer
#     ./x.py build src/tools/rustbook
#     ./x.py build src/tools/rustdoc
#     ./x.py build src/tools/rustfmt
#     ./x.py build src/tools/tidy
#     ./x.py build src/tools/unstable-book-gen

# function __xpy_in_rust
#     if type -q x 
#         x help  > /dev/null 2> /dev/null

#     end
# end

# function __xpy_build_dirs
# end

