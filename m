Content-Type: multipart/mixed; boundary="===============8900389683862572496=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: [PATCH 08/13] ap: remove 'psk' from Start()
Date: Tue, 20 Oct 2020 13:27:56 -0700
Message-ID: <dd81d04b6c09790a6b3ca42d688b80e9e39d50d7.camel@gmail.com>
In-Reply-To: <CAOq732Jnp+U4DF6_7zN5fGQV6FCqBrOsQ-eqnLuwsftLT9Z7_w@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8900389683862572496==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Tue, 2020-10-20 at 22:19 +0200, Andrew Zaborowski wrote:
> Hi James,
> =

> On Tue, 20 Oct 2020 at 20:03, James Prestwood <prestwoj@gmail.com>
> wrote:
> > This has been replaced by dedicated provisioning files.
> =

> This is going to break Network Manager and an additional problem is
> that clients have no way to tell which version of IWD they're talking
> to.
> =

> Currently clients can get a basic AP set up with just one method call
> and with this change they will have to use two different APIs:
> filesystem + D-Bus.  Can we make the config file optional?  In my
> opinion this is a significant complication for the typical use-case
> (Android-style UI), while in most other scenarios hostapd is going to
> work better.

Yes Denis and I discussed this and came to the same conclusion. Better
to have a quick and easy Start() API and probably add a sparate API for
starting with a config file.

But if Network Manager is actually using this API we should probably
remove the "experimental" label from the docs. I wasn't aware of this
which is why I thought it was fine modifying it.

Thanks,
James

> =

> Best regards

--===============8900389683862572496==--

