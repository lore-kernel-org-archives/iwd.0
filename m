Content-Type: multipart/mixed; boundary="===============0532042170452378071=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Interface not detected sometimes
Date: Tue, 04 Feb 2020 11:06:24 -0600
Message-ID: <2e72e05e-7a2a-6058-739e-f88c087b1b72@gmail.com>
In-Reply-To: <20200204145818.2820.84473@ml01.vlan13.01.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0532042170452378071==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Hector,

On 2/4/20 8:58 AM, hector(a)ikatu.com wrote:
> Also the message "No default interface for wiphy 0" is displayed in the c=
ase that doesn't work.

Are you running brcmfmac by any chance?

Anyhow, this particular issue *should* be fixed upstream by commit =

55f9639ee37c ("manager: Retry the interface setup if we get an EBUSY")

Regards,
-Denis
--===============0532042170452378071==--

