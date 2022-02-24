Content-Type: multipart/mixed; boundary="===============6401000533043354744=="
MIME-Version: 1.0
From: KeithG <ys3al35l at gmail.com>
To: iwd at lists.01.org
Subject: Scan while AP - testing
Date: Wed, 23 Feb 2022 19:08:22 -0600
Message-ID: <CAG17S_P5dNR4BpKuBLcr14tRcMCGP2eost4Fjk4Ef2GUYhuUQw@mail.gmail.com>
In-Reply-To: 06c90e881297acf641205d0a4360bbe1380d92cf.camel@gmail.com

--===============6401000533043354744==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I applied James' latest suggested patches and was trying to see how this wo=
rks.

IWD starts and I can get into AP mode and can connect. I tried connman
to see if it would scan and got no response.  So I went into iwctl to
see and saw this:

Access Point:
  ap list                                           List devices in AP mode
  ap <wlan> start <"network name"> <passphrase>     Start an access point
                                                    called "network name" w=
ith
                                                    a passphrase
  ap <wlan> start-profile <"network name">          Start an access
point based on a disk profile
  ap <wlan> stop                                    Stop a started access
                                                    point
  ap <wlan> show                                    Show AP info
  ap <wlan> scan                                    Start an AP scan
  ap <wlan> get-networks                            Get network list
after scanning

looking good, but tried it and did not get anything:

[iwd]# ap wlan0 show
                             Access Point Interface
---------------------------------------------------------------------------=
-----
  Settable  Property            Value
---------------------------------------------------------------------------=
-----
            Started             yes
            Name                RuneAudioAP
            Scanning            no

                                    Client 0
---------------------------------------------------------------------------=
-----
            Property            Value
---------------------------------------------------------------------------=
-----
            Address             60:f2:62:ae:70:fe
            TxBitrate           54000                Kbit/s
            RxBitrate           54000                Kbit/s

[iwd]# ap wlan0 scan
Operation not supported
[iwd]# ap wlan0 get-networks
                                    Networks
---------------------------------------------------------------------------=
-----
            Property            Value
---------------------------------------------------------------------------=
-----

Is this the 'right way'? Are there more settings I need in my main.conf?

Keith
--===============6401000533043354744==--

