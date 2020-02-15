Content-Type: multipart/mixed; boundary="===============0802422474593745507=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/6] frame-xchg: Don't use l_genl for additional nl80211
 sockets
Date: Sat, 15 Feb 2020 01:17:45 +0100
Message-ID: <20200215001748.20819-3-andrew.zaborowski@intel.com>
In-Reply-To: <20200215001748.20819-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0802422474593745507==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For nl80211 sockets other than our main l_genl object use socket io
directly, to avoid creating many instances of l_genl.  The only reason
we use multiple sockets is to work around an nl80211 design quirk that
requires closing the socket to unregister management frame watches.
Normally there should not be a need to create multiple sockets in a
program.
---
 src/frame-xchg.c | 270 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 226 insertions(+), 44 deletions(-)

diff --git a/src/frame-xchg.c b/src/frame-xchg.c
index bb13975a..ce69c454 100644
--- a/src/frame-xchg.c
+++ b/src/frame-xchg.c
@@ -26,6 +26,8 @@
 =

 #include <errno.h>
 #include <stdarg.h>
+#include <sys/socket.h>
+#include <linux/genetlink.h>
 =

 #include <ell/ell.h>
 =

@@ -57,8 +59,10 @@ struct watch_group {
 	uint32_t id;
 	uint64_t wdev_id;
 	uint32_t unicast_watch_id;
-	struct l_genl *genl;
-	struct l_genl_family *nl80211;
+	struct l_io *io;
+	uint32_t nl_pid;
+	uint32_t nl_seq;
+	struct l_queue *write_queue;
 	struct watchlist watches;
 };
 =

@@ -113,6 +117,7 @@ struct frame_xchg_watch_data {
 =

 static struct l_queue *frame_xchgs;
 static struct l_genl_family *nl80211;
+static uint32_t nl80211_id;
 =

 struct frame_prefix_info {
 	uint16_t frame_type;
@@ -226,15 +231,12 @@ static void frame_watch_group_destroy(void *data)
 	struct watch_group *group =3D data;
 =

 	if (group->unicast_watch_id)
-		l_genl_remove_unicast_watch(group->genl,
+		l_genl_remove_unicast_watch(iwd_get_genl(),
 						group->unicast_watch_id);
 =

-	if (group->genl)
-		l_genl_unref(group->genl);
-
-	if (group->nl80211)
-		l_genl_family_free(group->nl80211);
-
+	l_io_destroy(group->io);
+	l_queue_destroy(group->write_queue,
+			(l_queue_destroy_func_t) l_genl_msg_unref);
 	watchlist_destroy(&group->watches);
 	l_free(group);
 }
@@ -252,40 +254,194 @@ static const struct watchlist_ops frame_watch_ops =
=3D {
 	.item_free =3D frame_watch_free,
 };
 =

+static bool frame_watch_group_io_write(struct l_io *io, void *user_data)
+{
+	struct watch_group *group =3D user_data;
+	struct l_genl_msg *msg;
+	const void *msg_data;
+	size_t msg_size;
+	ssize_t bytes_written;
+
+	msg =3D l_queue_pop_head(group->write_queue);
+	if (!msg)
+		return false;
+
+	msg_data =3D l_genl_msg_to_data(msg, nl80211_id, NLM_F_REQUEST,
+					++group->nl_seq, group->nl_pid,
+					&msg_size);
+	bytes_written =3D send(l_io_get_fd(group->io), msg_data, msg_size, 0);
+	l_genl_msg_unref(msg);
+
+	if (bytes_written < 0) {
+		l_error("Frame watch group socket write error: %s (%i)",
+			strerror(errno), errno);
+
+		l_queue_push_head(group->write_queue, msg);
+		return false;
+	}
+
+	return !l_queue_isempty(group->write_queue);
+}
+
+static bool frame_watch_group_io_read(struct l_io *io, void *user_data)
+{
+	struct watch_group *group =3D user_data;
+	struct cmsghdr *cmsg;
+	struct msghdr msg;
+	struct iovec iov;
+	unsigned char buf[8192];
+	unsigned char control[32];
+	ssize_t bytes_read;
+	struct nlmsghdr *nlmsg;
+	size_t nlmsg_len;
+	uint32_t nlmsg_group =3D 0;
+
+	memset(&iov, 0, sizeof(iov));
+	iov.iov_base =3D buf;
+	iov.iov_len =3D sizeof(buf);
+
+	memset(&msg, 0, sizeof(msg));
+	msg.msg_iov =3D &iov;
+	msg.msg_iovlen =3D 1;
+	msg.msg_control =3D control;
+	msg.msg_controllen =3D sizeof(control);
+
+	bytes_read =3D recvmsg(l_io_get_fd(group->io), &msg, 0);
+	if (bytes_read < 0) {
+		if (errno !=3D EAGAIN && errno !=3D EINTR) {
+			l_error("Frame watch group socket read error: %s (%i)",
+				strerror(errno), errno);
+			return false;
+		}
+
+		return true;
+	}
+
+	nlmsg_len =3D bytes_read;
+
+	for (cmsg =3D CMSG_FIRSTHDR(&msg); cmsg !=3D NULL;
+					cmsg =3D CMSG_NXTHDR(&msg, cmsg)) {
+		struct nl_pktinfo pktinfo;
+
+		if (cmsg->cmsg_level !=3D SOL_NETLINK)
+			continue;
+
+		if (cmsg->cmsg_type !=3D NETLINK_PKTINFO)
+			continue;
+
+		memcpy(&pktinfo, CMSG_DATA(cmsg), sizeof(pktinfo));
+
+		nlmsg_group =3D pktinfo.group;
+	}
+
+	if (nlmsg_group) /* Ignore multicast */
+		return true;
+
+	for (nlmsg =3D iov.iov_base; NLMSG_OK(nlmsg, nlmsg_len);
+				nlmsg =3D NLMSG_NEXT(nlmsg, nlmsg_len)) {
+		struct l_genl_msg *genl_msg;
+
+		if (nlmsg->nlmsg_type !=3D nl80211_id) /* Ignore other families */
+			continue;
+
+		if (nlmsg->nlmsg_seq)	/* Ignore responses */
+			continue;
+
+		genl_msg =3D l_genl_msg_new_from_data((void *) nlmsg,
+							nlmsg->nlmsg_len);
+		if (!genl_msg)
+			continue;
+
+		frame_watch_unicast_notify(genl_msg, group);
+		l_genl_msg_unref(genl_msg);
+	}
+
+	return true;
+}
+
+static void frame_watch_group_io_destroy(void *user_data)
+{
+	struct watch_group *group =3D user_data;
+
+	group->io =3D NULL;
+
+	if (l_queue_remove(watch_groups, group)) {
+		l_error("Frame watch group socket closed");
+
+		frame_watch_group_destroy(group);
+	}
+}
+
 static struct watch_group *frame_watch_group_new(uint64_t wdev_id, uint32_=
t id)
 {
 	struct watch_group *group =3D l_new(struct watch_group, 1);
+	struct sockaddr_nl addr;
+	socklen_t addrlen =3D sizeof(addr);
+	int fd =3D -1, pktinfo =3D 1;
 =

 	group->id =3D id;
 	group->wdev_id =3D wdev_id;
 	watchlist_init(&group->watches, &frame_watch_ops);
 =

-	if (id =3D=3D 0)
-		group->genl =3D l_genl_ref(iwd_get_genl());
-	else {
-		group->genl =3D l_genl_new();
-		if (!group->genl)
-			goto err;
-	}
-
-	group->unicast_watch_id =3D l_genl_add_unicast_watch(group->genl,
+	if (id =3D=3D 0) {
+		group->unicast_watch_id =3D l_genl_add_unicast_watch(
+						iwd_get_genl(),
 						NL80211_GENL_NAME,
 						frame_watch_unicast_notify,
 						group, NULL);
-	if (!group->unicast_watch_id) {
-		l_error("Registering for unicast notification failed");
-		goto err;
+		if (unlikely(!group->unicast_watch_id)) {
+			l_error("Registering for unicast notification failed");
+			goto err;
+		}
+
+		return group;
 	}
 =

-	group->nl80211 =3D l_genl_family_new(group->genl, NL80211_GENL_NAME);
-	if (!group->nl80211) {
-		l_error("Failed to obtain nl80211");
+	/*
+	 * If we need to add groups using genl sockets other than our main
+	 * genl socket (iwd_get_genl()), use raw io instead of l_genl.  This
+	 * way we don't have to query the genl families -- we already know
+	 * nl80211 is present -- and the handling is simpler, and l_genl,
+	 * while it would work, is not meant to have multiple instances
+	 * per program.
+	 */
+	fd =3D socket(PF_NETLINK,
+			SOCK_DGRAM | SOCK_CLOEXEC | SOCK_NONBLOCK,
+			NETLINK_GENERIC);
+	if (unlikely(fd < 0))
 		goto err;
-	}
+
+	memset(&addr, 0, sizeof(addr));
+	addr.nl_family =3D AF_NETLINK;
+	addr.nl_pid =3D 0;
+
+	if (unlikely(bind(fd, (struct sockaddr *) &addr, sizeof(addr)) < 0))
+		goto err;
+
+	if (unlikely(getsockname(fd, (struct sockaddr *) &addr, &addrlen) < 0))
+		goto err;
+
+	group->nl_pid =3D addr.nl_pid;
+
+	if (unlikely(setsockopt(fd, SOL_NETLINK, NETLINK_PKTINFO,
+					&pktinfo, sizeof(pktinfo)) < 0))
+		goto err;
+
+	group->io =3D l_io_new(fd);
+	if (unlikely(!group->io))
+		goto err;
+
+	l_io_set_close_on_destroy(group->io, true);
+	l_io_set_read_handler(group->io, frame_watch_group_io_read, group,
+				frame_watch_group_io_destroy);
+	group->write_queue =3D l_queue_new();
 =

 	return group;
 =

 err:
+	if (fd > -1)
+		close(fd);
+
 	frame_watch_group_destroy(group);
 	return NULL;
 }
@@ -410,8 +566,14 @@ bool frame_watch_add(uint64_t wdev_id, uint32_t group_=
id, uint16_t frame_type,
 	l_genl_msg_append_attr(msg, NL80211_ATTR_FRAME_MATCH,
 				prefix_len, prefix);
 =

-	l_genl_family_send(group->nl80211, msg, frame_watch_register_cb,
-				L_UINT_TO_PTR(frame_type), NULL);
+	if (group->id =3D=3D 0)
+		l_genl_family_send(nl80211, msg, frame_watch_register_cb,
+					L_UINT_TO_PTR(frame_type), NULL);
+	else {
+		l_queue_push_tail(group->write_queue, msg);
+		l_io_set_write_handler(group->io, frame_watch_group_io_write,
+					group, NULL);
+	}
 =

 	return true;
 }
@@ -1054,46 +1216,66 @@ static void frame_xchg_config_notify(struct l_genl_=
msg *msg, void *user_data)
 =

 static int frame_xchg_init(void)
 {
-	struct watch_group *default_group =3D frame_watch_group_new(0, 0);
+	struct watch_group *default_group;
+	const struct l_genl_family_info *info;
 =

-	if (!default_group)
+	nl80211 =3D l_genl_family_new(iwd_get_genl(), NL80211_GENL_NAME);
+	if (!nl80211) {
+		l_error("Failed to obtain nl80211");
 		return -EIO;
+	}
 =

-	if (!l_genl_family_register(default_group->nl80211, "config",
-					frame_xchg_config_notify,
+	info =3D l_genl_family_get_info(nl80211);
+	nl80211_id =3D l_genl_family_info_get_id(info);
+
+	default_group =3D frame_watch_group_new(0, 0);
+	if (!default_group)
+		goto error;
+
+	if (!l_genl_family_register(nl80211, "config", frame_xchg_config_notify,
 					NULL, NULL)) {
 		l_error("Registering for config notifications failed");
-		frame_watch_group_destroy(default_group);
-		default_group =3D NULL;
-		return -EIO;
+		goto error;
 	}
 =

-	if (!l_genl_family_register(default_group->nl80211, "mlme",
-					frame_xchg_mlme_notify, NULL, NULL)) {
+	if (!l_genl_family_register(nl80211, "mlme", frame_xchg_mlme_notify,
+					NULL, NULL)) {
 		l_error("Registering for MLME notification failed");
-		frame_watch_group_destroy(default_group);
-		default_group =3D NULL;
-		return -EIO;
+		goto error;
 	}
 =

 	watch_groups =3D l_queue_new();
 	l_queue_push_tail(watch_groups, default_group);
-	nl80211 =3D default_group->nl80211;
 =

 	return 0;
+
+error:
+	if (nl80211) {
+		l_genl_family_free(nl80211);
+		nl80211 =3D NULL;
+	}
+
+	if (default_group)
+		frame_watch_group_destroy(default_group);
+
+	return -EIO;
 }
 =

 static void frame_xchg_exit(void)
 {
-	l_queue_destroy(watch_groups, frame_watch_group_destroy);
+	struct l_queue *groups =3D watch_groups;
+
+	l_queue_destroy(frame_xchgs, frame_xchg_cancel);
+	frame_xchgs =3D NULL;
+
 	watch_groups =3D NULL;
+	l_queue_destroy(groups, frame_watch_group_destroy);
+
+	l_genl_family_free(nl80211);
 	nl80211 =3D NULL;
 =

 	l_queue_destroy(wdevs, l_free);
 	wdevs =3D NULL;
-
-	l_queue_destroy(frame_xchgs, frame_xchg_cancel);
-	frame_xchgs =3D NULL;
 }
 =

 IWD_MODULE(frame_xchg, frame_xchg_init, frame_xchg_exit);
-- =

2.20.1

--===============0802422474593745507==--

