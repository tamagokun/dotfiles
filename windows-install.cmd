@if not exist "%HOME%" @set HOME=%USERPROFILE%

@set BASE_DIR=%HOME%\dotfiles
call mklink /J %HOME%\.vim %BASE_DIR%\vim\vim.symlink
call mklink %HOME%\.vimrc %BASE_DIR%\vim\vimrc.symlink
call mklink %HOME%\_vimrc %BASE_DIR%\vim\vimrc.symlink
call mklink %HOME%\.gvimrc %BASE_DIR%\vim\gvimrc.symlink
call mklink %HOME%\_gvimrc %BASE_DIR%\vim\gvimrc.symlink
