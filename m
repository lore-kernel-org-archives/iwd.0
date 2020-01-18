Content-Type: multipart/mixed; boundary="===============7729550559400338213=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: How to monitor signal strenght
Date: Sat, 18 Jan 2020 17:50:08 +0100
Message-ID: <20200118165008.xjnclomubjzaysko@beryllium.lan>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7729550559400338213==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Another question pop up while updating the iwd plugin for ConnMan.

Currently, the plugin listens for scanning signal. Whenever iwd has
finished with scanning the plugin calls GetOrderedNetworks in order to
update the signal strengths. Is this still the right way to do it?

I see in the docs that there is a SignalLevelAgent hierarchy. I am not
entirely sure if I need it or what it's the purpose of it. The docs
talks about an array for thresholds and references
net.connman.iwd.Device.RegisterSignalLevelAgent in device-api.txt. But
there is no documentation about it.

Also there is an empty signal-level-agent-api.txt file.

So far the GetOrderednetworks approach works but I'd love to hear if I
am doing it wrong.

Thanks,
Daniel
--===============7729550559400338213==--

