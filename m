Content-Type: multipart/mixed; boundary="===============4628660025892066504=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 1/3] ap: add StartProfile DBus method
Date: Mon, 02 Nov 2020 13:58:29 -0600
Message-ID: <23eb61e8-3dbc-e455-edab-fc1aee9dc594@gmail.com>
In-Reply-To: <20201102182851.2580877-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4628660025892066504==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 11/2/20 12:28 PM, James Prestwood wrote:
> Users can now start an AP from settings based on a profile
> on disk. The only argument is the SSID which will be used to
> lookup the profile. If no profile is found a NotFound error
> will be returned. Any invalid profiles will result in an
> Invalid return.
> ---
>   src/ap.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>   src/ap.h |  3 +++
>   2 files changed, 71 insertions(+), 2 deletions(-)
> =

> v2:
>   * Removed the profile loading from ap_init and squashed that into
>     this commit.
>   * This now loads the profiles on the fly when the dbus method is
>     called. This avoids the need for any special ap_config handling
>     of transient vs disk profiles.
> =


All applied, thanks.

Regards,
-Denis

--===============4628660025892066504==--

