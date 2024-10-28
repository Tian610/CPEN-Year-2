package tiktok;

import java.util.function.Predicate;

public class TikTokHelper {

    public static Predicate<TikTokVideo> filterVideosByLikes(int minLikes) {
        return video -> video.getLikes() > minLikes;
    }

    public static Predicate<TikTokVideo> filterVideosByUser(String username) {
        return video -> video.getUploader().equals(username);
    }

    public static Predicate<TikTokVideo> filterVideosByEngagement(int engagement) {
        return video -> (video.getLikes() + video.getComments() + video.getShares()) > engagement;
    }
}
