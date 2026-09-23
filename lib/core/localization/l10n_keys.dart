/// Centralized string keys used across the app.
///
/// Keeping keys here (instead of inline literals) lets the analyzer catch
/// typos and keeps localization dictionaries in sync.
abstract final class L10nKeys {
  // Brand / basics
  static const appName = 'appName';
  static const tagline = 'tagline';
  static const back = 'back';
  static const next = 'next';
  static const continueText = 'continueText';
  static const skip = 'skip';
  static const done = 'done';
  static const cancel = 'cancel';
  static const yes = 'yes';
  static const no = 'no';
  static const save = 'save';
  static const close = 'close';
  static const retry = 'retry';
  static const add = 'add';
  static const edit = 'edit';
  static const remove = 'remove';
  static const search = 'search';
  static const today = 'today';
  static const offline = 'offline';
  static const online = 'online';

  // Greeting
  static const goodMorning = 'goodMorning';
  static const goodAfternoon = 'goodAfternoon';
  static const goodEvening = 'goodEvening';
  static const goodNight = 'goodNight';

  // Navigation
  static const navHome = 'navHome';
  static const navGarden = 'navGarden';
  static const navActivities = 'navActivities';
  static const navMemories = 'navMemories';
  static const navProfile = 'navProfile';
  static const navMystery = 'navMystery';

  // Onboarding
  static const onboardingWelcomeTitle = 'onboardingWelcomeTitle';
  static const onboardingWelcomeBody = 'onboardingWelcomeBody';
  static const onboardingNameTitle = 'onboardingNameTitle';
  static const onboardingNameHint = 'onboardingNameHint';
  static const onboardingRegionTitle = 'onboardingRegionTitle';
  static const onboardingRegionHint = 'onboardingRegionHint';
  static const onboardingRegionList = 'onboardingRegionList';
  static const onboardingLanguageTitle = 'onboardingLanguageTitle';
  static const onboardingLanguageBody = 'onboardingLanguageBody';
  static const onboardingFamilyTitle = 'onboardingFamilyTitle';
  static const onboardingFamilyBody = 'onboardingFamilyBody';
  static const onboardingAddFamily = 'onboardingAddFamily';
  static const onboardingEmergencyTitle = 'onboardingEmergencyTitle';
  static const onboardingEmergencyBody = 'onboardingEmergencyBody';
  static const onboardingEmergencyName = 'onboardingEmergencyName';
  static const onboardingEmergencyPhone = 'onboardingEmergencyPhone';
  static const onboardingEmergencyRelation = 'onboardingEmergencyRelation';
  static const onboardingDoneTitle = 'onboardingDoneTitle';
  static const onboardingDoneBody = 'onboardingDoneBody';
  static const onboardingStart = 'onboardingStart';

  // Home
  static const homeWhatsGrowing = 'homeWhatsGrowing';
  static const homeTodayActivity = 'homeTodayActivity';
  static const homeActivityDuration = 'homeActivityDuration';
  static const homeMinutes = 'homeMinutes';
  static const homeMemoryOfDay = 'homeMemoryOfDay';
  static const homeMemoryLocked = 'homeMemoryLocked';
  static const homeMemoryUnlocked = 'homeMemoryUnlocked';
  static const homeContinueActivity = 'homeContinueActivity';
  static const homeFamilyMemory = 'homeFamilyMemory';
  static const homeFamilyMemoryEmpty = 'homeFamilyMemoryEmpty';
  static const homeSos = 'homeSos';
  static const homeSosSubtitle = 'homeSosSubtitle';
  static const homeGardenPreview = 'homeGardenPreview';
  static const homeEngine = 'homeEngine';
  static const homeEngineReady = 'homeEngineReady';
  static const homeWelcomeBack = 'homeWelcomeBack';
  static const homeNoActivity = 'homeNoActivity';
  static const homeNoActivityBody = 'homeNoActivityBody';

  // Garden
  static const gardenTitle = 'gardenTitle';
  static const gardenSectionAll = 'gardenSectionAll';
  static const gardenSectionFamily = 'gardenSectionFamily';
  static const gardenSectionChildhood = 'gardenSectionChildhood';
  static const gardenSectionPlaces = 'gardenSectionPlaces';
  static const gardenSectionFestivals = 'gardenSectionFestivals';
  static const gardenEmpty = 'gardenEmpty';
  static const gardenEmptyBody = 'gardenEmptyBody';
  static const gardenPoints = 'gardenPoints';
  static const gardenLevel = 'gardenLevel';
  static const gardenSeed = 'gardenSeed';
  static const gardenPlant = 'gardenPlant';
  static const gardenFlower = 'gardenFlower';
  static const gardenTree = 'gardenTree';
  static const gardenMilestone = 'gardenMilestone';
  static const gardenGrowth = 'gardenGrowth';
  static const gardenDidYouKnow = 'gardenDidYouKnow';
  static const gardenPlantSeed = 'gardenPlantSeed';

  // Activities
  static const activitiesTitle = 'activitiesTitle';
  static const activitiesToday = 'activitiesToday';
  static const activitiesLibrary = 'activitiesLibrary';
  static const mainGamesTitle = 'mainGamesTitle';
  static const activitiesStart = 'activitiesStart';
  static const activitiesCompleted = 'activitiesCompleted';
  static const activitiesInProgress = 'activitiesInProgress';
  static const activitiesNotStarted = 'activitiesNotStarted';
  static const activityYoureDone = 'activityYoureDone';
  static const activityPraise = 'activityPraise';
  static const activityHint = 'activityHint';
  static const activityTryAgain = 'activityTryAgain';
  static const activityOptionsHint = 'activityOptionsHint';
  static const activityTapToMatch = 'activityTapToMatch';
  static const activityNext = 'activityNext';
  static const activityFinish = 'activityFinish';
  // How-to-play tutorial shown before a game starts.
  static const tutListen = 'tutListen';
  static const tutPairs1 = 'tutPairs1';
  static const tutPairs2 = 'tutPairs2';
  static const tutPairs3 = 'tutPairs3';
  static const tutSeq1 = 'tutSeq1';
  static const tutSeq2 = 'tutSeq2';
  static const tutSeq3 = 'tutSeq3';
  static const tutRecall1 = 'tutRecall1';
  static const tutRecall2 = 'tutRecall2';
  static const tutRecall3 = 'tutRecall3';
  static const tutMatch1 = 'tutMatch1';
  static const tutMatch2 = 'tutMatch2';
  static const tutMatch3 = 'tutMatch3';
  static const tutNoFail = 'tutNoFail';
  static const activityGroupLetsAgain = 'activityGroupLetsAgain';
  static const activityGroupTogether = 'activityGroupTogether';
  static const activityGreatJob = 'activityGreatJob';
  static const activityKitchen = 'activityKitchen';
  static const activityShopping = 'activityShopping';
  static const activityMatching = 'activityMatching';
  static const activitySequence = 'activitySequence';
  static const activityRecognition = 'activityRecognition';
  static const activityAssociation = 'activityAssociation';
  static const activityRecall = 'activityRecall';
  static const activityAttention = 'activityAttention';
  static const activityPairs = 'activityPairs';
  static const activitySequenceRecall = 'activitySequenceRecall';
  static const activityFindChanged = 'activityFindChanged';
  static const activityDurationSuffix = 'activityDurationSuffix';
  static const activityTodayDone = 'activityTodayDone';
  static const activityTodayDoneBody = 'activityTodayDoneBody';
  static const activityGardenGrew = 'activityGardenGrew';
  static const activityMemoryUnlocked = 'activityMemoryUnlocked';
  static const activityReadAloud = 'activityReadAloud';

  // Virtual kitchen
  static const kitchenTitle = 'kitchenTitle';
  static const kitchenMakeChai = 'kitchenMakeChai';
  static const kitchenMakeChaiPrompt = 'kitchenMakeChaiPrompt';
  static const kitchenSteps = 'kitchenSteps';
  static const kitchenTapInOrder = 'kitchenTapInOrder';
  static const kitchenCorrectOrder = 'kitchenCorrectOrder';
  static const kitchenBreakfast = 'kitchenBreakfast';
  static const kitchenBreakfastHint = 'kitchenBreakfastHint';
  static const kitchenBreakfastPrompt = 'kitchenBreakfastPrompt';

  // Shopping
  static const shopTitle = 'shopTitle';
  static const shopGetMilkBread = 'shopGetMilkBread';
  static const shopGetMilkBreadPrompt = 'shopGetMilkBreadPrompt';
  static const shopBudget = 'shopBudget';
  static const shopBasket = 'shopBasket';
  static const shopTotal = 'shopTotal';
  static const shopWithinBudget = 'shopWithinBudget';
  static const shopOverBudget = 'shopOverBudget';
  static const shopCheckout = 'shopCheckout';
  static const shopBuy = 'shopBuy';
  static const shopSell = 'shopSell';
  static const shopVeggies = 'shopVeggies';
  static const shopVeggiesPrompt = 'shopVeggiesPrompt';

  static const recKitchenItem = 'recKitchenItem';
  static const recKitchenItemPrompt = 'recKitchenItemPrompt';
  static const recCurrency = 'recCurrency';
  static const recCurrencyPrompt = 'recCurrencyPrompt';
  static const matchFestival = 'matchFestival';
  static const matchFestivalPrompt = 'matchFestivalPrompt';
  static const matchObjectUse = 'matchObjectUse';
  static const matchObjectUsePrompt = 'matchObjectUsePrompt';
  static const seqMorning = 'seqMorning';
  static const seqMorningPrompt = 'seqMorningPrompt';
  static const seqRoute = 'seqRoute';
  static const seqRoutePrompt = 'seqRoutePrompt';
  static const assoRegion = 'assoRegion';
  static const assoRegionPrompt = 'assoRegionPrompt';
  static const assoHarvest = 'assoHarvest';
  static const assoHarvestPrompt = 'assoHarvestPrompt';
  static const attnVeg = 'attnVeg';
  static const attnVegPrompt = 'attnVegPrompt';
  static const recallSong = 'recallSong';
  static const recallSongPrompt = 'recallSongPrompt';

  // Options text for generic activities

  // Find the pairs
  static const pairsFruits = 'pairsFruits';
  static const pairsKitchen = 'pairsKitchen';
  static const pairsRemember = 'pairsRemember';
  static const pairsStart = 'pairsStart';
  static const pairsFound = 'pairsFound';

  // Remember the sequence
  static const seqRecallItems = 'seqRecallItems';
  static const seqRecallNumbers = 'seqRecallNumbers';
  static const seqRecallWatch = 'seqRecallWatch';
  static const seqRecallRepeat = 'seqRecallRepeat';

  // What changed?
  static const changeMarket = 'changeMarket';
  static const changeFestival = 'changeFestival';
  static const changeRemember = 'changeRemember';
  static const changeFind = 'changeFind';
  static const changeCorrect = 'changeCorrect';

  // Mystery memory
  static const mysteryTitle = 'mysteryTitle';
  static const mysteryLocked = 'mysteryLocked';
  static const mysteryLockedBody = 'mysteryLockedBody';
  static const mysteryUnlocked = 'mysteryUnlocked';
  static const mysteryUnlockedBody = 'mysteryUnlockedBody';
  static const mysteryCuriosity = 'mysteryCuriosity';
  static const mysteryOpen = 'mysteryOpen';

  // Memories
  static const memoriesTitle = 'memoriesTitle';
  static const memoriesEmpty = 'memoriesEmpty';
  static const memoriesEmptyBody = 'memoriesEmptyBody';
  static const memoriesFamily = 'memoriesFamily';
  static const memoriesPlaces = 'memoriesPlaces';
  static const memoriesFestivals = 'memoriesFestivals';
  static const memoriesChildhood = 'memoriesChildhood';
  static const memoriesKindPhoto = 'memoriesKindPhoto';
  static const memoriesKindVoice = 'memoriesKindVoice';
  static const memoriesKindText = 'memoriesKindText';
  static const memoriesKindSound = 'memoriesKindSound';
  static const memoriesKindPlace = 'memoriesKindPlace';
  static const memoriesAddedBy = 'memoriesAddedBy';
  static const memoriesWhoIsThis = 'memoriesWhoIsThis';
  static const memoriesPlayVoice = 'memoriesPlayVoice';
  static const memoriesThisIsMe = 'memoriesThisIsMe';
  static const memoriesNotMe = 'memoriesNotMe';

  // Profile
  static const profileTitle = 'profileTitle';
  static const profileLanguage = 'profileLanguage';
  static const profileRegion = 'profileRegion';
  static const profileVoiceLanguage = 'profileVoiceLanguage';
  static const profileVoicePrompts = 'profileVoicePrompts';
  static const profileTextSize = 'profileTextSize';
  static const profileReducedMotion = 'profileReducedMotion';
  static const profileSoundEffects = 'profileSoundEffects';
  static const profileFamily = 'profileFamily';
  static const profileContacts = 'profileContacts';
  static const profileDemoMode = 'profileDemoMode';
  static const profileReminders = 'profileReminders';
  static const profileNeedHelp = 'profileNeedHelp';

  // Reminders
  static const remindersTitle = 'remindersTitle';
  static const remindersEmpty = 'remindersEmpty';
  static const remindersNew = 'remindersNew';
  static const remindersTitleLabel = 'remindersTitleLabel';
  static const remindersDetailLabel = 'remindersDetailLabel';
  static const remindersTime = 'remindersTime';
  static const remindersDays = 'remindersDays';
  static const remindersEveryday = 'remindersEveryday';
  static const remindersEnabled = 'remindersEnabled';
  static const remindersMedicine = 'remindersMedicine';
  static const remindersAppointment = 'remindersAppointment';
  static const remindersRoutine = 'remindersRoutine';

  // Days
  static const dayMon = 'dayMon';
  static const dayTue = 'dayTue';
  static const dayWed = 'dayWed';
  static const dayThu = 'dayThu';
  static const dayFri = 'dayFri';
  static const daySat = 'daySat';
  static const daySun = 'daySun';

  // SOS
  static const sosTitle = 'sosTitle';
  static const sosExplain = 'sosExplain';
  static const sosHold = 'sosHold';
  static const sosHoldBody = 'sosHoldBody';
  static const sosActiveTitle = 'sosActiveTitle';
  static const sosActiveBody = 'sosActiveBody';
  static const sosContacting = 'sosContacting';
  static const sosContactFamily = 'sosContactFamily';
  static const sosContacted = 'sosContacted';
  static const sosWaitingResponse = 'sosWaitingResponse';
  static const sosEscalating = 'sosEscalating';
  static const sosCancelled = 'sosCancelled';
  static const sosCancelAction = 'sosCancelAction';
  static const sosDone = 'sosDone';
  static const sosHelpOnWay = 'sosHelpOnWay';
  static const sosNoContacts = 'sosNoContacts';
  static const sosNoContactsBody = 'sosNoContactsBody';
  static const sosAddContact = 'sosAddContact';
  static const sosDisclaimer = 'sosDisclaimer';
  static const sosContactedPerson = 'sosContactedPerson';
  static const sosEscalatedTo = 'sosEscalatedTo';
  static const sosAcknowledged = 'sosAcknowledged';
  static const sosNotSilent = 'sosNotSilent';
  static const sosAlertNotDelivered = 'sosAlertNotDelivered';

  // Caregiver
  static const careTitle = 'careTitle';
  static const careDashboard = 'careDashboard';
  static const carePatients = 'carePatients';
  static const careMemories = 'careMemories';
  static const careContacts = 'careContacts';
  static const careSettings = 'careSettings';
  static const careAddMemory = 'careAddMemory';
  static const careAddContact = 'careAddContact';
  static const careEngagement = 'careEngagement';
  static const careActivitiesWeek = 'careActivitiesWeek';
  static const careGardenProgress = 'careGardenProgress';
  static const careRecentActivity = 'careRecentActivity';
  static const careNoPatients = 'careNoPatients';
  static const careNoPatientsBody = 'careNoPatientsBody';
  static const careAddPatient = 'careAddPatient';
  static const carePerformanceNote = 'carePerformanceNote';
  static const careUploadPhoto = 'careUploadPhoto';
  static const careChoosePhoto = 'careChoosePhoto';
  static const careReplacePhoto = 'careReplacePhoto';
  static const careUploadVideo = 'careUploadVideo';
  static const careChooseVideo = 'careChooseVideo';
  static const careReplaceVideo = 'careReplaceVideo';
  static const careRecording = 'careRecording';
  static const careMicPermission = 'careMicPermission';
  static const careVoiceRecordingFailed = 'careVoiceRecordingFailed';
  static const careMemoryKindVideo = 'careMemoryKindVideo';
  static const camera = 'camera';
  static const gallery = 'gallery';
  static const careRecordVoice = 'careRecordVoice';
  static const careWriteMemory = 'careWriteMemory';
  static const careMemoryTitle = 'careMemoryTitle';
  static const careMemoryCaption = 'careMemoryCaption';
  static const careMemoryRelation = 'careMemoryRelation';
  static const careMemoryCategory = 'careMemoryCategory';
  static const careContactName = 'careContactName';
  static const careContactPhone = 'careContactPhone';
  static const careContactPriority = 'careContactPriority';
  static const careContactRelation = 'careContactRelation';
  static const careEscalationTimeout = 'careEscalationTimeout';
  static const careIncidentStatus = 'careIncidentStatus';
  static const careAckSos = 'careAckSos';
  static const careResponding = 'careResponding';
  static const careActiveAlerts = 'careActiveAlerts';
  static const careDashboardSubtitle = 'careDashboardSubtitle';

  // Caregiver server (FastAPI) view
  static const careSosLive = 'careSosLive';
  static const careSosRespondedBy = 'careSosRespondedBy';
  static const careLinkTitle = 'careLinkTitle';
  static const careLinkBody = 'careLinkBody';
  static const careLinkCode = 'careLinkCode';
  static const careLinkCodeHint = 'careLinkCodeHint';
  static const careLinkConnect = 'careLinkConnect';
  static const careLinkDone = 'careLinkDone';
  static const careLinkSuccess = 'careLinkSuccess';
  static const careLinkFailed = 'careLinkFailed';
  static const careTrendsTitle = 'careTrendsTitle';
  static const careTrendsBody = 'careTrendsBody';
  static const careTrendsNoData = 'careTrendsNoData';
  static const careAiDifficulty = 'careAiDifficulty';
  static const careAiAccuracy = 'careAiAccuracy';
  static const careAiRealSessions = 'careAiRealSessions';
  static const careAiDemoSessions = 'careAiDemoSessions';

  // Premium caregiver dashboard
  static const careNavGames = 'careNavGames';
  static const careNavRoutine = 'careNavRoutine';
  static const careGreetSubtitle = 'careGreetSubtitle';
  static const careNotifEmpty = 'careNotifEmpty';
  static const careWellnessScore = 'careWellnessScore';
  static const careStatusStable = 'careStatusStable';
  static const careStatusAttention = 'careStatusAttention';
  static const careLastSynced = 'careLastSynced';
  static const careMinAgo = 'careMinAgo';
  static const careGamesWeek = 'careGamesWeek';
  static const careRoutineCompletion = 'careRoutineCompletion';
  static const careCurrentStreak = 'careCurrentStreak';
  static const careMoodCheckins = 'careMoodCheckins';
  static const careDayUnit = 'careDayUnit';
  static const careDaysUnit = 'careDaysUnit';
  static const careActivityTitle = 'careActivityTitle';
  static const careWeekly = 'careWeekly';
  static const careMonthly = 'careMonthly';
  static const careNoActivityWeek = 'careNoActivityWeek';
  static const careMoodTitle = 'careMoodTitle';
  static const careMoodHappy = 'careMoodHappy';
  static const careMoodCalm = 'careMoodCalm';
  static const careMoodNeutral = 'careMoodNeutral';
  static const careMoodLow = 'careMoodLow';
  static const careMood7Days = 'careMood7Days';
  static const careMoodInsight = 'careMoodInsight';
  static const careMoodNoData = 'careMoodNoData';
  static const careSkillsTitle = 'careSkillsTitle';
  static const careSkillMemory = 'careSkillMemory';
  static const careSkillAttention = 'careSkillAttention';
  static const careSkillLanguage = 'careSkillLanguage';
  static const careSkillReasoning = 'careSkillReasoning';
  static const careSkillProcessing = 'careSkillProcessing';
  static const careInsightToday = 'careInsightToday';
  static const careInsightBody = 'careInsightBody';
  static const careInsightBodyReal = 'careInsightBodyReal';
  static const careViewDetails = 'careViewDetails';
  static const careInsightDisclaimer = 'careInsightDisclaimer';
  static const careAttentionTitle = 'careAttentionTitle';
  static const careAttentionEmpty = 'careAttentionEmpty';
  static const careAlertSos = 'careAlertSos';
  static const careAlertRoutineMissed = 'careAlertRoutineMissed';
  static const careAlertMoodDown = 'careAlertMoodDown';
  static const careAlertSessionPending = 'careAlertSessionPending';
  static const careAlertSeverityHigh = 'careAlertSeverityHigh';
  static const careAlertSeverityMedium = 'careAlertSeverityMedium';
  static const careAlertSeverityLow = 'careAlertSeverityLow';
  static const careWeeklySummary = 'careWeeklySummary';
  static const careSessionsCompleted = 'careSessionsCompleted';
  static const careAvgSessionDuration = 'careAvgSessionDuration';
  static const careRoutineAdherence = 'careRoutineAdherence';
  static const careMoodTrend = 'careMoodTrend';
  static const careMoodTrendSlightlyDown = 'careMoodTrendSlightlyDown';
  static const careMoodTrendStable = 'careMoodTrendStable';
  static const careMoodTrendUp = 'careMoodTrendUp';
  static const careVsLastWeek = 'careVsLastWeek';
  static const careSyncedJustNow = 'careSyncedJustNow';
  static const careOfflineWaiting = 'careOfflineWaiting';
  static const careComingSoon = 'careComingSoon';
  static const careHomeSoon = 'careHomeSoon';
  static const careGamesSoon = 'careGamesSoon';
  static const careRoutineSoon = 'careRoutineSoon';
  static const careProfileSoon = 'careProfileSoon';

  // Patient settings server status
  static const serverPairingTitle = 'serverPairingTitle';
  static const serverPairingBody = 'serverPairingBody';
  static const serverUnlinked = 'serverUnlinked';
  static const serverLinked = 'serverLinked';

  // Sync & offline
  static const syncSavingOffline = 'syncSavingOffline';
  static const syncSavingOfflineBody = 'syncSavingOfflineBody';
  static const syncSynced = 'syncSynced';
  static const syncPending = 'syncPending';
  static const syncInfo = 'syncInfo';

  // Errors
  static const errorGeneric = 'errorGeneric';
  static const errorGenericBody = 'errorGenericBody';
  static const errorAudio = 'errorAudio';
  static const errorPermission = 'errorPermission';
  static const errorNoInternetAction = 'errorNoInternetAction';

  // Demo
  static const demoWelcome = 'demoWelcome';
  static const demoExplain = 'demoExplain';
  static const demoLoad = 'demoLoad';

  // Misc
  static const unitsPoints = 'unitsPoints';
  static const teaserChai = 'teaserChai';
  static const familiarityName = 'familiarityName';
  static const importantMemory = 'importantMemory';
  static const growing = 'growing';
  static const blooming = 'blooming';
  static const mature = 'mature';
  static const regionMap = 'regionMap';
  static const regionIndia = 'regionIndia';
  static const regionChoose = 'regionChoose';
  static const noVoice = 'noVoice';
  static const optional = 'optional';

  // Common patient actions / labels
  static const settings = 'settings';
  static const stop = 'stop';
  static const deleteAction = 'deleteAction';
  static const sosShort = 'sosShort';

  // Routines (patient home)
  static const routineAddTitle = 'routineAddTitle';
  static const routineAddBody = 'routineAddBody';
  static const timeLabel = 'timeLabel';
  static const routineNameLabel = 'routineNameLabel';
  static const routineNameHint = 'routineNameHint';
  static const routineKind = 'routineKind';
  static const medicineKind = 'medicineKind';
  static const waterKind = 'waterKind';
  static const addRoutine = 'addRoutine';
  static const homeRoutineSubtitle = 'homeRoutineSubtitle';
  static const routineCheckTitle = 'routineCheckTitle';
  static const routineCheckBody = 'routineCheckBody';
  static const addFirstRoutine = 'addFirstRoutine';
  static const deleteRoutineTitle = 'deleteRoutineTitle';
  static const deleteRoutineBody = 'deleteRoutineBody';
  static const deleteRoutineTooltip = 'deleteRoutineTooltip';

  // Memory composer (patient)
  static const profileMissing = 'profileMissing';
  static const memoriesSubtitle = 'memoriesSubtitle';
  static const memoryComposeHint = 'memoryComposeHint';
  static const createMemory = 'createMemory';
  static const addToMemory = 'addToMemory';
  static const memoryTitleLabel = 'memoryTitleLabel';
  static const memoryTitleHint = 'memoryTitleHint';
  static const memoryCaptionLabel = 'memoryCaptionLabel';
  static const memoryCaptionHint = 'memoryCaptionHint';
  static const memoriesKindVideo = 'memoriesKindVideo';
  static const voiceShort = 'voiceShort';
  static const textShort = 'textShort';
  static const categoryLabel = 'categoryLabel';
  static const saveMemory = 'saveMemory';
  static const memoryTitleRequired = 'memoryTitleRequired';
  static const stopVoiceFirst = 'stopVoiceFirst';
  static const memorySaved = 'memorySaved';
  static const addMemoryTooltip = 'addMemoryTooltip';
  static const photoAddFailed = 'photoAddFailed';
  static const videoAddFailed = 'videoAddFailed';
  static const voiceSaveFailed = 'voiceSaveFailed';
  static const micVoicePermission = 'micVoicePermission';
  static const recordingStartFailed = 'recordingStartFailed';
  static const savedMemoriesTitle = 'savedMemoriesTitle';
  static const attachmentsAddedOne = 'attachmentsAddedOne';
  static const attachmentsAddedMany = 'attachmentsAddedMany';

  // Caregiver achievements
  static const careAchieveFirstSteps = 'careAchieveFirstSteps';
  static const careAchieveFirstStepsBody = 'careAchieveFirstStepsBody';
  static const careAchieveSevenDay = 'careAchieveSevenDay';
  static const careAchieveSevenDayBody = 'careAchieveSevenDayBody';
  static const careAchieveGarden = 'careAchieveGarden';
  static const careAchieveGardenBody = 'careAchieveGardenBody';
  static const careAchievePerfect = 'careAchievePerfect';
  static const careAchievePerfectBody = 'careAchievePerfectBody';
  static const careAchieveEngagement = 'careAchieveEngagement';
  static const careAchieveEngagementBody = 'careAchieveEngagementBody';

  // Month abbreviations (charts / notes)
  static const monthJan = 'monthJan';
  static const monthFeb = 'monthFeb';
  static const monthMar = 'monthMar';
  static const monthApr = 'monthApr';
  static const monthMay = 'monthMay';
  static const monthJun = 'monthJun';
  static const monthJul = 'monthJul';
  static const monthAug = 'monthAug';
  static const monthSep = 'monthSep';
  static const monthOct = 'monthOct';
  static const monthNov = 'monthNov';
  static const monthDec = 'monthDec';

  // Language picker
  static const langChoose = 'langChoose';
  static const langPrimary = 'langPrimary';
  static const langNorthEast = 'langNorthEast';
  static const langMajor = 'langMajor';

  // Auth
  static const authSignUpTitle = 'authSignUpTitle';
  static const authSignUpBody = 'authSignUpBody';
  static const authLoginTitle = 'authLoginTitle';
  static const authLoginBody = 'authLoginBody';
  static const authUsername = 'authUsername';
  static const authUsernameHint = 'authUsernameHint';
  static const authDisplayName = 'authDisplayName';
  static const authPassword = 'authPassword';
  static const authPasswordHint = 'authPasswordHint';
  static const authConfirmPassword = 'authConfirmPassword';
  static const authRoleQuestion = 'authRoleQuestion';
  static const authRolePatient = 'authRolePatient';
  static const authRoleCaregiver = 'authRoleCaregiver';
  static const authCreate = 'authCreate';
  static const authSignIn = 'authSignIn';
  static const authSignOut = 'authSignOut';
  static const authAccount = 'authAccount';
  static const caregiverTitle = 'caregiverTitle';
  static const caregiverNotLinked = 'caregiverNotLinked';
  static const authBadCredentials = 'authBadCredentials';
  static const authUsernameTaken = 'authUsernameTaken';
  static const authPasswordMismatch = 'authPasswordMismatch';
  static const authUsernameShort = 'authUsernameShort';
  static const authUsernameInvalid = 'authUsernameInvalid';
  static const authPasswordShort = 'authPasswordShort';
  static const authNameRequired = 'authNameRequired';
  static const authSignOutConfirm = 'authSignOutConfirm';

  static const screenTitle = 'screenTitle';
  static const screenIntro = 'screenIntro';
  static const screenRarely = 'screenRarely';
  static const screenSometimes = 'screenSometimes';
  static const screenFrequently = 'screenFrequently';
  static const screenVeryFrequently = 'screenVeryFrequently';
  static const screenNotSure = 'screenNotSure';
  static const screenFinish = 'screenFinish';
  static const screenSkip = 'screenSkip';
  static const screenResultBack = 'screenResultBack';
  static const screenCheckAgain = 'screenCheckAgain';
  static const screenStartCheckup = 'screenStartCheckup';
  static const screenSkipped = 'screenSkipped';
  static const screenStatusGood = 'screenStatusGood';
  static const screenStatusGoodBody = 'screenStatusGoodBody';
  static const screenStatusWatch = 'screenStatusWatch';
  static const screenStatusWatchBody = 'screenStatusWatchBody';
  static const screenStatusDoctor = 'screenStatusDoctor';
  static const screenStatusDoctorBody = 'screenStatusDoctorBody';

  static const screenQ01 = 'screenQ01';
  static const screenQ02 = 'screenQ02';
  static const screenQ03 = 'screenQ03';
  static const screenQ04 = 'screenQ04';
  static const screenQ05 = 'screenQ05';
  static const screenQ06 = 'screenQ06';
  static const screenQ07 = 'screenQ07';
  static const screenQ08 = 'screenQ08';
  static const screenQ09 = 'screenQ09';
  static const screenQ10 = 'screenQ10';
  static const screenQ11 = 'screenQ11';
  static const screenQ12 = 'screenQ12';
  static const screenQ13 = 'screenQ13';
  static const screenQ14 = 'screenQ14';
  static const screenQ15 = 'screenQ15';
  static const navGames = 'navGames';
  static const homeWhatNeed = 'homeWhatNeed';
  static const homeLetsPlayTitle = 'homeLetsPlayTitle';
  static const homeLetsPlaySubtitle = 'homeLetsPlaySubtitle';
  static const homePlayCta = 'homePlayCta';
  static const chooseGameTitle = 'chooseGameTitle';
  static const chooseGameSubtitle = 'chooseGameSubtitle';
  static const gamesMoreTitle = 'gamesMoreTitle';
  static const gamePictureMatch = 'gamePictureMatch';
  static const gamePictureMatchDesc = 'gamePictureMatchDesc';
  static const gameRememberOrder = 'gameRememberOrder';
  static const gameRememberOrderDesc = 'gameRememberOrderDesc';
  static const gameWordRecall = 'gameWordRecall';
  static const gameWordRecallDesc = 'gameWordRecallDesc';
  static const gameShapeMatch = 'gameShapeMatch';
  static const gameShapeMatchDesc = 'gameShapeMatchDesc';
  static const levelSelectTitle = 'levelSelectTitle';
  static const levelSelectSubtitle = 'levelSelectSubtitle';
  static const levelTakeYourTime = 'levelTakeYourTime';
  static const levelEasy = 'levelEasy';
  static const levelEasyDesc = 'levelEasyDesc';
  static const levelMedium = 'levelMedium';
  static const levelMediumDesc = 'levelMediumDesc';
  static const levelHard = 'levelHard';
  static const levelHardDesc = 'levelHardDesc';
  static const progressRecentActivity = 'progressRecentActivity';
  static const progressGamesPlayed = 'progressGamesPlayed';
  static const progressBestStreak = 'progressBestStreak';
  static const progressStreakDays = 'progressStreakDays';
  static const progressGamesThisWeek = 'progressGamesThisWeek';
  static const progressKeepGoing = 'progressKeepGoing';
  static const settingsComfortTitle = 'settingsComfortTitle';
  static const settingsTextSize = 'settingsTextSize';
  static const settingsTextSizeSmall = 'settingsTextSizeSmall';
  static const settingsTextSizeMedium = 'settingsTextSizeMedium';
  static const settingsTextSizeLarge = 'settingsTextSizeLarge';
  static const settingsHighContrast = 'settingsHighContrast';
  static const settingsHighContrastBody = 'settingsHighContrastBody';
  static const settingsHowToPlayBody = 'settingsHowToPlayBody';

  // ── Caregiver ───────────────────────────────────────────────────────────

  // Brand
  static const careBrandName = 'careBrandName';
  static const careBrandTagline = 'careBrandTagline';
  static const carePreviewBadge = 'carePreviewBadge';

  // Home
  static const careGreetingMorning = 'careGreetingMorning';
  static const careGreetingAfternoon = 'careGreetingAfternoon';
  static const careGreetingEvening = 'careGreetingEvening';
  static const careGreetingOk = 'careGreetingOk';
  static const careHomeToday = 'careHomeToday';
  static const careStatsGames = 'careStatsGames';
  static const careStatsMinutes = 'careStatsMinutes';
  static const careStatsAvgScore = 'careStatsAvgScore';
  static const careStatsStreak = 'careStatsStreak';
  static const careHomeToReview = 'careHomeToReview';
  static const careReviewWeeklyTitle = 'careReviewWeeklyTitle';
  static const careReviewWeeklyBody = 'careReviewWeeklyBody';
  static const careReviewGardenTitle = 'careReviewGardenTitle';
  static const careReviewGardenBody = 'careReviewGardenBody';
  static const careReviewMilestoneTitle = 'careReviewMilestoneTitle';
  static const careReviewMilestoneBody = 'careReviewMilestoneBody';
  static const careReviewMedicationTitle = 'careReviewMedicationTitle';
  static const careReviewMedicationBody = 'careReviewMedicationBody';
  static const careCtaReview = 'careCtaReview';
  static const careCtaView = 'careCtaView';
  static const careQuickActions = 'careQuickActions';
  static const careQuickMemories = 'careQuickMemories';
  static const careQuickNotes = 'careQuickNotes';
  static const careQuickAchievements = 'careQuickAchievements';
  static const careQuickEmergency = 'careQuickEmergency';
  static const careWeekHighlight = 'careWeekHighlight';
  static const careWeekUp = 'careWeekUp';
  static const careWeekSessionsDone = 'careWeekSessionsDone';
  static const careSosLiveTitle = 'careSosLiveTitle';
  static const careSosLiveSubtitle = 'careSosLiveSubtitle';
  static const careSosOpen = 'careSosOpen';
  static const careNoLinkedTitle = 'careNoLinkedTitle';
  static const careNoLinkedBody = 'careNoLinkedBody';
  static const careLinkNow = 'careLinkNow';
  static const patient = 'patient';

  // Progress
  static const careProgressTitle = 'careProgressTitle';
  static const careMonth = 'careMonth';
  static const careAllTime = 'careAllTime';
  static const careSeeAll = 'careSeeAll';
  static const careTodayTitle = 'careTodayTitle';
  static const careThisWeek = 'careThisWeek';
  static const careWeekMinutes = 'careWeekMinutes';
  static const careWeekCompletedCount = 'careWeekCompletedCount';
  static const careStreakCount = 'careStreakCount';
  static const careWeekGoal = 'careWeekGoal';
  static const careImprovementLabel = 'careImprovementLabel';
  static const careSkillStrengths = 'careSkillStrengths';
  static const carePct = 'carePct';
  static const careRecentSessions = 'careRecentSessions';
  static const careSessionMeta = 'careSessionMeta';
  static const careScoreLabel = 'careScoreLabel';
  static const careGamePerformance = 'careGamePerformance';
  static const carePlayedCount = 'carePlayedCount';
  static const careBestScore = 'careBestScore';
  static const careAvgScoreShort = 'careAvgScoreShort';
  static const careLastPlayed = 'careLastPlayed';
  static const careNoDataTitle = 'careNoDataTitle';
  static const careNoDataBody = 'careNoDataBody';
  static const careGamesEmptyTitle = 'careGamesEmptyTitle';
  static const careGamesEmptyBody = 'careGamesEmptyBody';
  static const careSessionsEmptyTitle = 'careSessionsEmptyTitle';
  static const careGoToGames = 'careGoToGames';

  // Games
  static const careGamesTitle = 'careGamesTitle';
  static const careGamesSubtitle = 'careGamesSubtitle';
  static const careAllCategory = 'careAllCategory';
  static const careNotPlayedYet = 'careNotPlayedYet';
  static const careGameTitle = 'careGameTitle';
  static const careGameHowToPlay = 'careGameHowToPlay';
  static const careGamePlayCountTitle = 'careGamePlayCountTitle';
  static const careGameBestTitle = 'careGameBestTitle';
  static const careGameAvgTitle = 'careGameAvgTitle';
  static const careGameMinsTitle = 'careGameMinsTitle';
  static const careGameMostActiveDay = 'careGameMostActiveDay';
  static const careGameRecentRounds = 'careGameRecentRounds';
  static const careGameNoSessions = 'careGameNoSessions';
  static const careCatMemory = 'careCatMemory';
  static const careCatAttention = 'careCatAttention';
  static const careCatLanguage = 'careCatLanguage';
  static const careCatProblemSolving = 'careCatProblemSolving';
  static const careCatRecognition = 'careCatRecognition';
  static const careCatNarrative = 'careCatNarrative';
  static const careCatMath = 'careCatMath';
  static const careCatVisual = 'careCatVisual';

  // Notes
  static const careNotesTitle = 'careNotesTitle';
  static const careNotesSubtitle = 'careNotesSubtitle';
  static const careAddNote = 'careAddNote';
  static const careNoteFilterAll = 'careNoteFilterAll';
  static const careNoteKindGeneral = 'careNoteKindGeneral';
  static const careNoteKindMood = 'careNoteKindMood';
  static const careNoteKindActivities = 'careNoteKindActivities';
  static const careNoteKindHealth = 'careNoteKindHealth';
  static const careNotesCount = 'careNotesCount';
  static const careNotesEmptyTitle = 'careNotesEmptyTitle';
  static const careNotesEmptyBody = 'careNotesEmptyBody';
  static const careNoteDelete = 'careNoteDelete';
  static const careNoteSaved = 'careNoteSaved';
  static const careNoteTitle = 'careNoteTitle';
  static const careNoteBodyHint = 'careNoteBodyHint';
  static const careNoteKindLabel = 'careNoteKindLabel';

  // Memories
  static const careMemoriesTitle = 'careMemoriesTitle';
  static const careMemoriesSubtitle = 'careMemoriesSubtitle';
  static const careMemoriesEmptyTitle = 'careMemoriesEmptyTitle';
  static const careMemoriesEmptyBody = 'careMemoriesEmptyBody';
  static const careMemoryCategoryFamily = 'careMemoryCategoryFamily';
  static const careMemoryCategoryChildhood = 'careMemoryCategoryChildhood';
  static const careMemoryCategoryPlaces = 'careMemoryCategoryPlaces';
  static const careMemoryCategoryFestivals = 'careMemoryCategoryFestivals';
  static const careMemoryCategoryImportant = 'careMemoryCategoryImportant';
  static const careMemoryPlacementLabel = 'careMemoryPlacementLabel';
  static const careMemoryPlacementGarden = 'careMemoryPlacementGarden';
  static const careMemoryPlacementMystery = 'careMemoryPlacementMystery';
  static const careMemoryPlacementRescue = 'careMemoryPlacementRescue';
  static const careMemoryPlacementPicture = 'careMemoryPlacementPicture';
  static const careMemoryPlacementObjects = 'careMemoryPlacementObjects';
  static const careMemoryAddTitle = 'careMemoryAddTitle';
  static const careMemoryTitleField = 'careMemoryTitleField';
  static const careMemoryCaptionField = 'careMemoryCaptionField';
  static const careMemoryPlaceField = 'careMemoryPlaceField';
  static const careMemoryKindLabel = 'careMemoryKindLabel';
  static const careMemoryKindText = 'careMemoryKindText';
  static const careMemoryKindPhoto = 'careMemoryKindPhoto';
  static const careMemoryKindVoice = 'careMemoryKindVoice';
  static const careMemoryKindSound = 'careMemoryKindSound';
  static const careMemoryKindPlace = 'careMemoryKindPlace';
  static const careMemoryPlacesLabel = 'careMemoryPlacesLabel';
  static const careMemorySaved = 'careMemorySaved';
  static const careMemoryCount = 'careMemoryCount';

  // Achievements
  static const careAchieveTitle = 'careAchieveTitle';
  static const careAchieveSubtitle = 'careAchieveSubtitle';
  static const careAchieveUnlocked = 'careAchieveUnlocked';
  static const careAchieveInProgress = 'careAchieveInProgress';
  static const careAchieveHowTitle = 'careAchieveHowTitle';
  static const careAchieveHowBody = 'careAchieveHowBody';
  static const careAchieveCount = 'careAchieveCount';

  // Profile
  static const careProfileTitle = 'careProfileTitle';
  static const careProfileAge = 'careProfileAge';
  static const careProfileRegion = 'careProfileRegion';
  static const careProfileLinked = 'careProfileLinked';
  static const careProfileNotLinked = 'careProfileNotLinked';
  static const careProfileSyncNote = 'careProfileSyncNote';
  static const careProfileLinkButton = 'careProfileLinkButton';
  static const careProfilePairingTitle = 'careProfilePairingTitle';
  static const careProfilePairingHint = 'careProfilePairingHint';
  static const careProfilePairingPlaceholder = 'careProfilePairingPlaceholder';
  static const careProfilePairingSuccess = 'careProfilePairingSuccess';
  static const careProfilePairingError = 'careProfilePairingError';
  static const careProfileSosTitle = 'careProfileSosTitle';
  static const careProfileContactsCount = 'careProfileContactsCount';
  static const careProfileSettings = 'careProfileSettings';
  static const careProfileCaregiverTitle = 'careProfileCaregiverTitle';
  static const careProfileLogout = 'careProfileLogout';
  static const careProfileLogoutConfirm = 'careProfileLogoutConfirm';

  // Settings
  static const careSettingsTitle = 'careSettingsTitle';
  static const careSettingsDisplay = 'careSettingsDisplay';
  static const careSettingsFontSize = 'careSettingsFontSize';
  static const careSettingsFontSmall = 'careSettingsFontSmall';
  static const careSettingsFontNormal = 'careSettingsFontNormal';
  static const careSettingsFontLarge = 'careSettingsFontLarge';
  static const careSettingsHighContrast = 'careSettingsHighContrast';
  static const careSettingsHighContrastBody = 'careSettingsHighContrastBody';
  static const careSettingsNotifications = 'careSettingsNotifications';
  static const careSettingsReminders = 'careSettingsReminders';
  static const careSettingsRemindersBody = 'careSettingsRemindersBody';
  static const careSettingsWeekly = 'careSettingsWeekly';
  static const careSettingsWeeklyBody = 'careSettingsWeeklyBody';
  static const careSettingsSosAlerts = 'careSettingsSosAlerts';
  static const careSettingsSosAlertsBody = 'careSettingsSosAlertsBody';
  static const careSettingsAbout = 'careSettingsAbout';
  static const careSettingsAboutBody = 'careSettingsAboutBody';

  // Emergency
  static const careEmergencyTitle = 'careEmergencyTitle';
  static const careEmergencySubtitle = 'careEmergencySubtitle';
  static const careCallFamily = 'careCallFamily';
  static const careCallFamilyBody = 'careCallFamilyBody';
  static const careCallServices = 'careCallServices';
  static const careCallServicesBody = 'careCallServicesBody';
  static const careSmsFamily = 'careSmsFamily';
  static const careSmsFamilyBody = 'careSmsFamilyBody';
  static const careEmergencyLive = 'careEmergencyLive';
  static const careEmergencyLiveBody = 'careEmergencyLiveBody';
  static const careAcknowledge = 'careAcknowledge';
  static const careEscalate = 'careEscalate';
  static const careResolve = 'careResolve';
  static const careAcknowledged = 'careAcknowledged';
  static const careEscalationLadder = 'careEscalationLadder';
  static const careStepCallPrimary = 'careStepCallPrimary';
  static const careStepSmsPrimary = 'careStepSmsPrimary';
  static const careStepCallFamily = 'careStepCallFamily';
  static const carePrimaryContacts = 'carePrimaryContacts';
  static const careFamilyContacts = 'careFamilyContacts';
  static const careCallShort = 'careCallShort';
  static const careSmsShort = 'careSmsShort';
  static const careNoContactsTitle = 'careNoContactsTitle';
  static const careNoContactsBody = 'careNoContactsBody';
  static const careHistory = 'careHistory';
  static const careHistoryEmpty = 'careHistoryEmpty';
  static const careCancel = 'careCancel';
  static const careByCaregiver = 'careByCaregiver';
  static const careNavMore = 'careNavMore';
}
