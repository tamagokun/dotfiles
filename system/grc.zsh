# GRC colorizes nifty unix tools all over the place
if $(grc &>/dev/null 2>&1)
then
  source `brew --prefix`/etc/grc.bashrc
fi
