Content-Type: multipart/mixed; boundary="===============5307131979891003457=="
MIME-Version: 1.0
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Subject: [RFC connman v2 0/1] Add wpa_supplicant WPA3-SAE support
Date: Thu, 27 May 2021 18:41:33 -0300
Message-ID: <20210527214134.33792-1-ariel.dalessandro@collabora.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5307131979891003457==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

Here's another attemp on adding WPA3-SAE support to connman
(wpa_supplicant backend).

I'd like comments on the following mainly:

Based on plugin/iwd.c, a private data struct is added to each network
in plugin/wifi.c so it can keep track of keymgmt capabilities, needed to
use WPA3-SAE if it's available. See RFC v1 thread for more details.

Note that this is an RFC patchset. Feel free to give any kind of
feedback, always appreciated :-)

Changes from v1:
* Dropped changes to service API.
* Unified WPA3-SAE under WPA-PSK.
* Added private data struct to network in plugin/wifi.c

Regards,

Ariel D'Alessandro (1):
  WIP: Add wpa_supplicant WPA3-SAE support

 gsupplicant/gsupplicant.h | 10 ++++++++++
 gsupplicant/supplicant.c  | 33 ++++++++++++++++++++++++++++++---
 plugins/wifi.c            | 21 +++++++++++++++++++++
 3 files changed, 61 insertions(+), 3 deletions(-)

-- =

2.30.2

--===============5307131979891003457==--

