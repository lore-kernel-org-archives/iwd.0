Content-Type: multipart/mixed; boundary="===============6449320226594005684=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v3 1/2] hwsim: allow concurrent radio creations
Date: Wed, 16 Feb 2022 16:28:11 -0600
Message-ID: <92e0d3f4-5ae1-caff-7126-52b25b473468@gmail.com>
In-Reply-To: 20220216193943.1411659-1-prestwoj@gmail.com

--===============6449320226594005684==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 2/16/22 13:39, James Prestwood wrote:
> Currently CreateRadio only allows a single outstanding DBus message
> until the radio is fully created. 99% of the time this is just fine
> but in order to test dual phy cards there needs to be support for
> phy's appearing at the same time.
> =

> This required storing the pending DBus message inside the radio object
> rather than a single static variable.
> =

> The code was refactored to handle the internal radio info objects better
> for the various cases:
>   - Creation from CreateRadio()
>   - Radio already existed before hwsim started, or created externally
>   - Existing radio changed name, address, etc.
> =

> First, Name is now a required option to CreateRadio(). This allows
> the radio info to be pushed to the queue immediately (also allowing the
> pending DBus message to be tracked). Then, when the NEW_RADIO event
> fires the pending radio can be looked up (by name) and filled with the
> remaining info.
> =

> If the radio was not found by name but a matching ID was found this is
> the 'changed' case and the radio is re-initialized with the changed
> values.
> =

> If neither name or ID matches the radio was created externally, or
> prior to hwsim starting. A radio info object is created at this time
> and initialized.
> =

> The ID was changed to a signed integer in order to initialize it to an
> invalid number -1. Doing this was required since a pending uninitalized
> radio ID (0) could match an existing radio ID. This required some
> bounds checks in case the kernels counter reaches an extremely high value.
> This isn't likely to ever happen in practice.
> ---
>   tools/hwsim.c | 187 +++++++++++++++++++++++++++-----------------------
>   1 file changed, 101 insertions(+), 86 deletions(-)
> =


Both applied, thanks.

Regards,
-Denis

--===============6449320226594005684==--

