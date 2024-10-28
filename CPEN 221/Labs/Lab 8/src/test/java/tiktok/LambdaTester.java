package tiktok;

import java.util.List;
import java.time.LocalDateTime;
import java.util.function.Predicate;
import java.util.stream.Collectors;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;

public class LambdaTester {
    private static TikTokVideo vid1 = new TikTokVideo("vid1", "user1", 150, 50, 30, 5000,
            LocalDateTime.now().minusDays(2));
    private static TikTokVideo vid2 = new TikTokVideo("vid2", "user2", 90, 20, 10, 3000,
            LocalDateTime.now().minusDays(5));
    private static TikTokVideo vid3 = new TikTokVideo("vid3", "user1", 200, 70, 50, 10000,
            LocalDateTime.now().minusDays(3));
    private static TikTokVideo vid4 = new TikTokVideo("vid4", "user3", 50, 5, 3, 1000,
            LocalDateTime.now().minusDays(1));
    private static List<TikTokVideo> videos = List.of(vid1, vid2, vid3, vid4);

    public static List<TikTokVideo> filterVideos(List<TikTokVideo> videoList, Predicate<TikTokVideo> condition) {
        return videoList.stream().
                filter(condition).
                collect(Collectors.toList());
    }

    @Test
    public void testLambdaLikes() {
        Predicate<TikTokVideo> condition = TikTokHelper.filterVideosByLikes(100);
        List<TikTokVideo> filteredVideos = filterVideos(videos, condition);
        assertEquals(List.of(vid1, vid3), filteredVideos);
    }

    @Test
    public void testLambdaUser() {
        Predicate<TikTokVideo> condition = TikTokHelper.filterVideosByUser("user1");
        List<TikTokVideo> filteredVideos = filterVideos(videos, condition);
        assertEquals(List.of(vid1, vid3), filteredVideos);
    }

    @Test
    public void testLambdaEngagement() {
        Predicate<TikTokVideo> condition = TikTokHelper.filterVideosByEngagement(100);
        List<TikTokVideo> filteredVideos = filterVideos(videos, condition);
        assertEquals(List.of(vid1, vid2, vid3), filteredVideos);
    }

    @Test
    public void testLambdaComposition() {
        Predicate<TikTokVideo> conditionLikes = TikTokHelper.filterVideosByLikes(100);
        Predicate<TikTokVideo> conditionEngagement = TikTokHelper.filterVideosByEngagement(260);
        List<TikTokVideo> filteredVideos = filterVideos(videos, conditionLikes.and(conditionEngagement));
        assertEquals(List.of(vid3), filteredVideos);
    }
}
