class DetailModel {
    int? id;
    String? slug;
    String? name;
    String? nameOriginal;
    String? description;
    int? metacritic;
    List<MetacriticPlatform>? metacriticPlatforms;
    String? released;
    bool? tba;
    String? updated;
    String? backgroundImage;
    String? backgroundImageAdditional;
    String? website;
    double? rating;
    int? ratingTop;
    List<Rating>? ratings;
    Map<String, int>? reactions;
    int? added;
    AddedByStatus? addedByStatus;
    int? playtime;
    int? screenshotsCount;
    int? moviesCount;
    int? creatorsCount;
    int? achievementsCount;
    int? parentAchievementsCount;
    String? redditUrl;
    String? redditName;
    String? redditDescription;
    String? redditLogo;
    int? redditCount;
    int? twitchCount;
    int? youtubeCount;
    int? reviewsTextCount;
    int? ratingsCount;
    int? suggestionsCount;
    List<String>? alternativeNames;
    String? metacriticUrl;
    int? parentsCount;
    int? additionsCount;
    int? gameSeriesCount;
    dynamic? userGame;
    int? reviewsCount;
    String? saturatedColor;
    String? dominantColor;
    List<ParentPlatform>? parentPlatforms;
    List<PlatformElement>? platforms;
    List<Store>? stores;
    List<Developer>? developers;
    List<Developer>? genres;
    List<Developer>? tags;
    List<Developer>? publishers;
    EsrbRating? esrbRating;
    dynamic? clip;
    String? descriptionRaw;

    DetailModel({
        this.id,
        this.slug,
        this.name,
        this.nameOriginal,
        this.description,
        this.metacritic,
        this.metacriticPlatforms,
        this.released,
        this.tba,
        this.updated,
        this.backgroundImage,
        this.backgroundImageAdditional,
        this.website,
        this.rating,
        this.ratingTop,
        this.ratings,
        this.reactions,
        this.added,
        this.addedByStatus,
        this.playtime,
        this.screenshotsCount,
        this.moviesCount,
        this.creatorsCount,
        this.achievementsCount,
        this.parentAchievementsCount,
        this.redditUrl,
        this.redditName,
        this.redditDescription,
        this.redditLogo,
        this.redditCount,
        this.twitchCount,
        this.youtubeCount,
        this.reviewsTextCount,
        this.ratingsCount,
        this.suggestionsCount,
        this.alternativeNames,
        this.metacriticUrl,
        this.parentsCount,
        this.additionsCount,
        this.gameSeriesCount,
        this.userGame,
        this.reviewsCount,
        this.saturatedColor,
        this.dominantColor,
        this.parentPlatforms,
        this.platforms,
        this.stores,
        this.developers,
        this.genres,
        this.tags,
        this.publishers,
        this.esrbRating,
        this.clip,
        this.descriptionRaw,
    },);
}

class AddedByStatus {
    int? yet;
    int? owned;
    int? beaten;
    int? toplay;
    int? dropped;
    int? playing;

    AddedByStatus({
        this.yet,
        this.owned,
        this.beaten,
        this.toplay,
        this.dropped,
        this.playing,
    });
}

class Developer {
    int? id;
    String? name;
    String? slug;
    int? gamesCount;
    String? imageBackground;
    String? domain;
    Language? language;

    Developer({
        this.id,
        this.name,
        this.slug,
        this.gamesCount,
        this.imageBackground,
        this.domain,
        this.language,
    });
}

enum Language { ENG }

class EsrbRating {
    int? id;
    String? name;
    String? slug;

    EsrbRating({
        this.id,
        this.name,
        this.slug,
    });
}

class MetacriticPlatform {
    int? metascore;
    String? url;
    MetacriticPlatformPlatform? platform;

    MetacriticPlatform({
        this.metascore,
        this.url,
        this.platform,
    });
}

class MetacriticPlatformPlatform {
    int? platform;
    String? name;
    String? slug;

    MetacriticPlatformPlatform({
        this.platform,
        this.name,
        this.slug,
    });
}

class ParentPlatform {
    EsrbRating? platform;

    ParentPlatform({
        this.platform,
    });
}

class PlatformElement {
    PlatformPlatform? platform;
    String? releasedAt;
    Requirements? requirements;

    PlatformElement({
        this.platform,
        this.releasedAt,
        this.requirements,
    });
}

class PlatformPlatform {
    int? id;
    String? name;
    String? slug;
    dynamic? image;
    dynamic? yearEnd;
    int? yearStart;
    int? gamesCount;
    String? imageBackground;

    PlatformPlatform({
        this.id,
        this.name,
        this.slug,
        this.image,
        this.yearEnd,
        this.yearStart,
        this.gamesCount,
        this.imageBackground,
    });
}

class Requirements {
    String? minimum;
    String? recommended;

    Requirements({
        this.minimum,
        this.recommended,
    });
}

class Rating {
    int? id;
    String? title;
    int? count;
    double? percent;

    Rating({
        this.id,
        this.title,
        this.count,
        this.percent,
    });
}

class Store {
    int? id;
    String? url;
    Developer? store;

    Store({
        this.id,
        this.url,
        this.store,
    });
}
