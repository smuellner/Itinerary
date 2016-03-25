Pod::Spec.new do |s|
  s.name         = 'PlacesAndRouting'
  s.version      = '1.0.0'
  s.summary      = 'HERE Places and Routing Framework for iOS'
  s.author = {
    'Sascha Müllner' => 'sascha.muellner@gmail.com'
  }
  s.platform = :ios, '8.0'
  s.requires_arc = true
  s.source_files = '*.{h,m}', 'Categories/*.{h,m}', 'Places/*.{h,m}', 'Routing/*.{h,m}'
  s.dependency     'AFNetworking', '~> 3.0.4'
  s.dependency     'YYModel', '~> 1.0.1'
end
