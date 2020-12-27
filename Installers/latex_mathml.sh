#based on https://github.com/jgm/texmath/ and d3

#if you don't already have haskell installed
curl -sSL https://get.haskellstack.org/ | sh
stack new simple
stack init

git clone https://github.com/jgm/texmath/
cd texmath
stack setup
stack install --flag texmath:executable

#verify it is installed and working
cd ~/.local/bin
echo 5|./texmath -f tex -t mathml


