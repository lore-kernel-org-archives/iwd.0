Content-Type: multipart/mixed; boundary="===============0376913717767846622=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: Cannot get ap mode to work
Date: Thu, 04 Jun 2020 10:30:27 +0200
Message-ID: <CAOq732+1OrFTr9m5rPupuiOK9gQt6KguyBPQZGBsUOy0oOMj7Q@mail.gmail.com>
In-Reply-To: <CAG17S_NU=nmTMUf=z5ceSEZ4ow2Cw4kfHTZ9NBZ6zvXMynNksA@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0376913717767846622==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Keith,

On Wed, 3 Jun 2020 at 19:17, KeithG <ys3al35l@gmail.com> wrote:
> I cannot get AP mode to function on my RPIs. If I try to do it by these c=
ommands:

Unfortunately IWD's AP mode is known to not work with the brcmfmac
driver used on most Pi models.  It's a full-mac card so the eapol
frames are probably handled differently.

I don't know why the interface is not assigned its IP though.

Best regards
--===============0376913717767846622==--

