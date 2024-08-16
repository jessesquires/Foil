Pod::Spec.new do |s|
   s.name = 'Foil'
   s.version = '5.1.2'
   s.license = 'MIT'

   s.summary = 'A lightweight property wrapper for UserDefaults'
   s.homepage = 'https://github.com/jessesquires/Foil'
   s.documentation_url = 'https://jessesquires.github.io/Foil'
   s.social_media_url = 'https://www.jessesquires.com'
   s.author = 'Jesse Squires'

   s.source = { :git => 'https://github.com/jessesquires/Foil.git', :tag => s.version }
   s.source_files = 'Sources/*.swift'

   s.swift_version = '5.10'

   s.ios.deployment_target = '13.0'
   s.tvos.deployment_target = '13.0'
   s.watchos.deployment_target = '6.0'
   s.osx.deployment_target = '11.0'

   s.requires_arc = true
end
