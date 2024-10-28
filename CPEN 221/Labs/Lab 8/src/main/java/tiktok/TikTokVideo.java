package tiktok;

import java.time.LocalDateTime;
import java.util.*;

public class TikTokVideo {
    private String videoId;
    private String uploader;
    private int likes;
    private int shares;
    private int comments;
    private int views;
    private LocalDateTime uploadTime;

    // Constructor, getters, and setters
    public TikTokVideo(String videoId, String uploader, int likes, int shares, int comments, int views,
            LocalDateTime uploadTime) {
        this.videoId = videoId;
        this.uploader = uploader;
        this.likes = likes;
        this.shares = shares;
        this.comments = comments;
        this.views = views;
        this.uploadTime = uploadTime;
    }

    public String getVideoId() {
        return videoId;
    }

    public String getUploader() {
        return uploader;
    }

    public int getLikes() {
        return likes;
    }

    public int getShares() {
        return shares;
    }

    public int getComments() {
        return comments;
    }

    public int getViews() {
        return views;
    }

    public LocalDateTime getUploadTime() {
        return uploadTime;
    }

    @Override
    public String toString() {
        return "Video ID: " + videoId + ", Uploader: " + uploader + ", Likes: " + likes + ", Shares: " + shares;
    }
}
