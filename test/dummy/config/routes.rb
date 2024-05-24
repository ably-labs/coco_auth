Rails.application.routes.draw do
  mount CocoAuth::Engine => "/coco_auth"
end
