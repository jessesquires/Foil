Pod::Spec.new do |s|
   s.name = 'Foil'
   s.version = '2.0.0'
   s.license = 'MIT'

   s.summary = 'A lightweight property wrapper for UserDefaults'
   s.homepage = 'https://github.com/jessesquires/Foil'
   s.documentation_url = 'https://jessesquires.github.io/Foil'
   s.social_media_url = 'https://twitter.com/jesse_squires'
   s.author = 'Jesse Squires'

   s.source = { :git => 'https://github.com/jessesquires/Foil.git', :tag => s.version }
   s.source_files = 'Sources/*.swift'

   s.swift_version = '5.5'

   s.ios.deployment_target = '9.0'
   s.tvos.deployment_target = '9.0'
   s.watchos.deployment_target = '5.0'
   s.osx.deployment_target = '10.13'

   s.requires_arc = true
end
