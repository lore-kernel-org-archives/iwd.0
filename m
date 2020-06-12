Content-Type: multipart/mixed; boundary="===============0734432354014364242=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 2/4] network: delay connect if ANQP has not completed
Date: Fri, 12 Jun 2020 14:10:25 -0500
Message-ID: <429ab6c3-6917-5359-19fd-91d0c9b658b9@gmail.com>
In-Reply-To: <ce52e43f72c0ca30d6a289b169eda61b072bf8c6.camel@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0734432354014364242==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

>> Maybe we should simply not close settings if agent requests are
>> pending in
>> network_autoconnect.
> =

> Really not do *anything* in network_autoconnect if agent requests are
> pending. Ill replace my network->connect_after_anqp check with network-
>> agent_request instead.

That's fine.  I suspect that if an agent request is in progress, then we're =

missing secrets or need the psk.  So, really the result should be equivalen=
t if =

you simply let the normal processing go on.

Regards,
-Denis
--===============0734432354014364242==--

