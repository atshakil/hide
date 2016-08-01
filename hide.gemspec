Gem::Specification.new do |s|
  s.name	= 'hide'
  s.version	= '0.1.1'
  s.date	= '2016-08-02'
  s.summary	= "A simple encryption utility"
  s.description = "Hide is a basic utility to encrypt/decrypt light-weight \
    data files"
  s.authors	= "Tahmid Shakil"
  s.email	= 'at.shakil.92@gmail.com'
  s.files	= Dir["lib/**/*.*"]
  s.executables += ["hide", "reveal"]
  s.homepage	= 'https://github.com/atshakil/hide'
  s.license	= 'CC-BY-SA-4.0'
end
