package streama

import grails.transaction.Transactional
import groovy.transform.CompileStatic
import groovy.util.logging.Slf4j
import org.springframework.scheduling.annotation.Scheduled


@Slf4j
@Transactional
class DbConnectionTimerService{

  static lazyInit = false
  UploadService uploadService
  SettingsService settingsService
  MigrationService migrationService
  int counter = 0;

  @Scheduled(fixedDelay = 180000L)
  void executeEveryOneMin(){
    settingsService.enableAnonymousUser();
    if(counter++%10==0){
      log.info("Transaction to keep connection alive every 3 minute. \\n baseUrl is: ")
      log.info(settingsService.getBaseUrl())
    }
    migrationService.removeTrailerFromMovies();
    uploadService.getStoragePaths();


  }
  @Scheduled(fixedDelay = 240000L)
  def serviceMethod() {
    uploadService.getSettingsService();
    migrationService.addProfilesToViewingStatusRecords()
    log.info("Transaction to keep connection alive every 4 minute. \\n baseUrl is: ")
    log.info(settingsService.getBaseUrl());
    migrationService.setTheMovieDBKey();
    migrationService.urlvalidationFix();
  }

}
