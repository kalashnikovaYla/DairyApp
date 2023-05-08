# DiaryApp

Diary App — это приложение для отслеживания настроения, которое позволяет добавлять в дневник заметки о физическом и эмоциональном состоянии. Вы можете прикреплять теги и фотографии к записям, чтобы сделать заметку более точной. Есть возможность просматривать статистику самочувствия за заданный период времени. 

Технологии: 
- UIKit (UICalendarView, UICollectionView, UITableView, UIImagePickerController, UIScrollView и т.д.)
- архитектура MVP
- архитектурные паттерны: Dependency Injection, Builder, Observer
- верстка выполнена кодом 
- есть возможность входа с Face ID
- данные хранятся на устройстве пользователя с помощью CoreData, за исключением фотографий, они записываются в файл с помощью FileManager 
- записи можно удалять по свайпу 
- для создания гистограмм использована библиотека Charts (pod Charts)
- есть поддержка светлой и темной темы 


![1i](https://user-images.githubusercontent.com/118187754/236789424-b6540a15-5f76-42d9-a5b0-db88059cfc82.png)

![2i](https://user-images.githubusercontent.com/118187754/236789468-f29b0fb6-cc6d-4efc-a4a3-2139f17d4a81.png)

![3i](https://user-images.githubusercontent.com/118187754/236789479-a394cb40-11a1-4ce6-a879-51ee65f0ec59.png)

![4i](https://user-images.githubusercontent.com/118187754/236789486-f9a39e3a-837d-452e-b29f-cba7c2961113.png)


TODO: 
- написать Unit Test
- добавить роутер 
- добавить определение локации, карту, экран для просмотра фотографий
- добавить pushNotification 
