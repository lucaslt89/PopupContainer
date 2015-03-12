Pod::Spec.new do |s|
  s.name             = 'PopupContainer'
  s.version          = '0.1.0'
  s.summary          = 'A Popup container that shows any UIView as a UIAlertView, taking care of animations and positioning.'
  s.homepage         = "https://github.com/lucaslt89/PopupContainer"
  s.license          = 'MIT'
  s.author           = { "Lucas Diez de Medina @ Technopix" => "lucas.diez@technopix.com.ar" }
  s.source           = { :git => "https://github.com/lucaslt89/PopupContainer.git", :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/*.swift'
  s.resource_bundles = {
    'PopupContainer' => ['Pod/Assets/*.png']
  }

end
