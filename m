Content-Type: multipart/mixed; boundary="===============1295197758196291187=="
MIME-Version: 1.0
From: =?utf-8?q?Joakim_Lotseng=C3=A5rd_=3Cjoakim=2El_at_orbital-systems=2Ecom?=
 =?utf-8?q?=3E?=
To: iwd at lists.01.org
Subject: Re: Possible bug when /var/lib/iwd is a symlink
Date: Thu, 14 Apr 2022 10:54:03 +0200
Message-ID: <CAELJiswi7Du1tEP_WmR2PN-_Pg+qPMep9NKUQYqWTAOxZHAtTw@mail.gmail.com>
In-Reply-To: CAELJisxEWR2dcZ9x4Xr3+r=myTv7X1ncD1wkx6rZ6O3YVJRMAA@mail.gmail.com

--===============1295197758196291187==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 14 Apr 2022 at 10:17, Joakim Lotseng=C3=A5rd
<joakim.l(a)orbital-systems.com> wrote:
>
> Possible bug when /var/lib/iwd is a symlink:
>

Follow up with a demo-patch that solves the problem, but probably isn't the
correct solution. I have not thought about any security implications this m=
ight
have.

Subject: [PATCH]: Resolve /var/lib/iwd before inotify

l_dir_watch_new() in knownnetworks.c will not follow symlink.

Quick hack to realname() resolve before adding the inotify.

If not done, the known network list will misbehave. Forgotten
networks will not be removed, and connected networks won't
get added to the known network list.
---
 src/knownnetworks.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/knownnetworks.c b/src/knownnetworks.c
index 487b7017..89c0efcc 100644
--- a/src/knownnetworks.c
+++ b/src/knownnetworks.c
@@ -1102,9 +1102,13 @@ static int known_networks_init(void)

  closedir(dir);

- storage_dir_watch =3D l_dir_watch_new(storage_dir,
+ // HAX: Resolve the storage_dir as l_dir_watch_new() won't follow symlinks
+ char *storage_dir_real =3D realpath(storage_dir, NULL);
+ storage_dir_watch =3D l_dir_watch_new(storage_dir_real,
  known_networks_watch_cb, NULL,
  known_networks_watch_destroy);
+ free(storage_dir_real);
+
  watchlist_init(&known_network_watches, NULL);

  return 0;
-- =

2.25.1
--===============1295197758196291187==--

