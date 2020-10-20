Content-Type: multipart/mixed; boundary="===============1750525081365589403=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 08/13] ap: remove 'psk' from Start()
Date: Tue, 20 Oct 2020 22:19:06 +0200
Message-ID: <CAOq732Jnp+U4DF6_7zN5fGQV6FCqBrOsQ-eqnLuwsftLT9Z7_w@mail.gmail.com>
In-Reply-To: <20201020180256.1630120-8-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1750525081365589403==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On Tue, 20 Oct 2020 at 20:03, James Prestwood <prestwoj@gmail.com> wrote:
>
> This has been replaced by dedicated provisioning files.

This is going to break Network Manager and an additional problem is
that clients have no way to tell which version of IWD they're talking
to.

Currently clients can get a basic AP set up with just one method call
and with this change they will have to use two different APIs:
filesystem + D-Bus.  Can we make the config file optional?  In my
opinion this is a significant complication for the typical use-case
(Android-style UI), while in most other scenarios hostapd is going to
work better.

Best regards
--===============1750525081365589403==--

