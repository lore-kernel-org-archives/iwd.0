Content-Type: multipart/mixed; boundary="===============0606115864283438360=="
MIME-Version: 1.0
From: Michael Johnson <mjohnson459@gmail.com>
Subject: Bug with RoamThreshold5G
Date: Mon, 12 Jul 2021 14:17:01 +0100
Message-ID: <CACsRnHXxRm=yNaPBzwGKkymvv9H3PDHfwGKbJnDc5VYcV0d=6w@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0606115864283438360==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi everyone,

I noticed that iwd wasn't roaming as much as I would expect given a
modified RoamTheshold5G
value. Looking into it, it seems like when the threshold is registered
for updates in
netdev_build_cmd_cqm_rssi_update we always use RoamThreshold. When
this bit of code is
called the frequency seems to always be 0 and so the non-5G variant is
used. This in turn becomes an issue once the frequency is set and the
correct threshold is used for other checks (at least if
RoamThreshold5G is configured higher than RoamThreshold).

Code:
netdev_build_cmd_cqm_rssi_update(...)
    int threshold =3D netdev->frequency > 4000 ? LOW_SIGNAL_THRESHOLD_5GHZ :

   LOW_SIGNAL_THRESHOLD;
    l_debug("frequency: %u, threshold: %d", netdev->frequency,
threshold); // added for debug

Config:
[General]
EnableNetworkConfiguration=3Dtrue
RoamThreshold=3D-60
RoamThreshold5G=3D-65

Output:
src/netdev.c:netdev_build_cmd_cqm_rssi_update() frequency: 0, threshold: -60

I'm not really sure what the right fix for this is. Can it just
request notifications for both
thresholds?

Regards,
Michael
--===============0606115864283438360==--

