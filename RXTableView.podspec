Pod::Spec.new do |s|
  s.name             = 'RXTableView'
  s.version          = '0.1.0'
  s.summary          = 'Reactive TableView'
  s.description      = <<-DESC
                        RXTableView 是基于 ReactiveCocoa 和 MVVM 的基础上造的一个 tableView 轮子。
                        抛弃繁杂重复的 TableView 代理实现和 Cell 管理，加入灵活的数据绑定，`RXTableView` 是一种新的体验。
                       DESC
  s.homepage         = 'https://github.com/laichanwai/RXTableView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'laizw' => 'i@laizw.cn' }
  s.source           = { :git => 'https://github.com/laichanwai/RXTableView.git', :tag => s.version }

  s.ios.deployment_target = '8.0'
  s.source_files = 'RXTableView/**/*.{h,m}'

  s.dependency 'MJRefresh', '3.1.12'
  s.dependency 'ReactiveObjC', '3.0.0'
end
