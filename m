Content-Type: multipart/mixed; boundary="===============7854546210692532538=="
MIME-Version: 1.0
From: carbonchauvinist@protonmail.ch
Subject: Re: Issue with iwd 1.3 + systemd-resolved + iwd's built-in network
 configuration not adding DNS servers
Date: Tue, 17 Dec 2019 00:49:30 +0000
Message-ID: <20191217004930.2770.48755@ml01.vlan13.01.org>
In-Reply-To: <308facdc-d57a-218e-3e26-d97ccaf9f169@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7854546210692532538==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Thanks Denis.

I can confirm the patch fixes the reported issue for me. iwd now adds the d=
omain as a search domain (without the prepended tilde) which keeps the Defa=
ultRoute value true and means I am able to perform lookups as expected. Tha=
nk you.
--===============7854546210692532538==--

