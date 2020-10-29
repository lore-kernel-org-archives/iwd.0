Content-Type: multipart/mixed; boundary="===============2620308445375103641=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH] frame-xchg: fix invalid read
Date: Thu, 29 Oct 2020 19:05:03 +0100
Message-ID: <CAOq732K01DA7_9iWTJAw2-x96ESj9996HZQd_8fmSKx-eWA9ww@mail.gmail.com>
In-Reply-To: <20201029163711.2377089-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2620308445375103641==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James!

On Thu, 29 Oct 2020 at 17:37, James Prestwood <prestwoj@gmail.com> wrote:
> This seems to happen occationally with testAP (potentially others).
> The invalid read appears to happen when the frame_xchg_tx_cb detects
> an early status and no ACK. In this particular case there is no
> retry interval so we reach the retry limit and 'done' the frame.
> This frees the 'fx' data all before the destroy callback can get
> called.

frame_xchg_done() should result in l_genl_family_cancel(fx->tx_cmd_id)
which would call the destroy callback before 'fx' is freed so there
should be some other reason this is happening.

One possibility is that we passed a wrong id to
l_genl_family_cancel(), can you check that it returns true?

By the way do you use the usb passthrough to trigger this?  I don't
think hwsim has the "early status" quirk.

Best regards
--===============2620308445375103641==--

