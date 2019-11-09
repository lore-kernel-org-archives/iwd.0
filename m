Content-Type: multipart/mixed; boundary="===============7689255535112675953=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 4/4] scan: Separate cck rates attr creation into logical
 block
Date: Sat, 09 Nov 2019 04:42:09 +0100
Message-ID: <19166F1D-20C3-4EDE-B1C3-D8F20CE42C07@holtmann.org>
In-Reply-To: <98fc86c6-65dd-0ddc-513c-9b30401d1644@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7689255535112675953==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> On Nov 9, 2019, at 04:33, Denis Kenzior <denkenz@gmail.com> wrote:
> =

> Hi Marcel,
> =

>> ok then, fair point. Can we somehow improve these cases with a comment t=
o ease reading and understanding the code.
> =

> So something like:
> =

> +                *
> +                * wiphy should have parsed the supported rates from the
> +                * kernel / driver.  If not, warn and give up
> =

> Or do you have something else in mind?

In addition I would also do

	* =

	* Keep full statement in L_WARN_ON to include more context when
	* the warning is triggered.

Just as a reminder for later days on why this is done. I am pretty sure oth=
erwise I am going to stumble over it again and ask the same question.

Regards

Marcel

--===============7689255535112675953==--

