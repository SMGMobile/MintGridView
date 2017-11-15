#
# Be sure to run `pod lib lint MintGridView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MintGridView'
  s.version          = '0.1.0'
  s.summary          = '快捷的表格组件，可支持九宫格和列表形式.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/ServyouMobile/MintGridView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'jihq' => '1026499974@qq.com' }
  s.source           = { :git => 'https://github.com/ServyouMobile/MintGridView.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'MintGridView/Classes/**/*'
  
  s.resource_bundles = {
    'MintGridViewImages' => ['MintGridView/Assets/*.png']
  }
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Kingfisher', '~> 4.2'
  s.dependency 'SwiftyJSON'
end
