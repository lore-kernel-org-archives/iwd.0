Content-Type: multipart/mixed; boundary="===============2354311373716675663=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 11/12] frame-xchg: Add frame_xchg_start
Date: Wed, 18 Mar 2020 15:45:30 +0100
Message-ID: <20200318144531.30613-11-andrew.zaborowski@intel.com>
In-Reply-To: <20200318144531.30613-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2354311373716675663==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/frame-xchg.c | 13 +++++++++++++
 src/frame-xchg.h |  4 ++++
 2 files changed, 17 insertions(+)

diff --git a/src/frame-xchg.c b/src/frame-xchg.c
index a4b6b740..45113d6d 100644
--- a/src/frame-xchg.c
+++ b/src/frame-xchg.c
@@ -1072,6 +1072,19 @@ static bool frame_xchg_match(const void *a, const vo=
id *b)
  * @resp_timeout was 0.  @frame is an iovec array terminated by an iovec
  * struct with NULL-iov_base.
  */
+void frame_xchg_start(uint64_t wdev_id, struct iovec *frame, uint32_t freq,
+			unsigned int retry_interval, unsigned int resp_timeout,
+			unsigned int retries_on_ack, uint32_t group_id,
+			frame_xchg_cb_t cb, void *user_data, ...)
+{
+	va_list args;
+
+	va_start(args, user_data);
+	frame_xchg_startv(wdev_id, frame, freq, retry_interval, resp_timeout,
+				retries_on_ack, group_id, cb, user_data, args);
+	va_end(args);
+}
+
 void frame_xchg_startv(uint64_t wdev_id, struct iovec *frame, uint32_t fre=
q,
 			unsigned int retry_interval, unsigned int resp_timeout,
 			unsigned int retries_on_ack, uint32_t group_id,
diff --git a/src/frame-xchg.h b/src/frame-xchg.h
index 93d528ae..45b0e5fa 100644
--- a/src/frame-xchg.h
+++ b/src/frame-xchg.h
@@ -43,6 +43,10 @@ bool frame_watch_add(uint64_t wdev_id, uint32_t group, u=
int16_t frame_type,
 bool frame_watch_group_remove(uint64_t wdev_id, uint32_t group);
 bool frame_watch_wdev_remove(uint64_t wdev_id);
 =

+void frame_xchg_start(uint64_t wdev_id, struct iovec *frame, uint32_t freq,
+			unsigned int retry_interval, unsigned int resp_timeout,
+			unsigned int retries_on_ack, uint32_t group_id,
+			frame_xchg_cb_t cb, void *user_data, ...);
 void frame_xchg_startv(uint64_t wdev_id, struct iovec *frame, uint32_t fre=
q,
 			unsigned int retry_interval, unsigned int resp_timeout,
 			unsigned int retries_on_ack, uint32_t group_id,
-- =

2.20.1

--===============2354311373716675663==--

