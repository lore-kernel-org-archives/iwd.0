Content-Type: multipart/mixed; boundary="===============3235620124588048460=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: iwd and NetworkManager
Date: Mon, 14 Dec 2020 19:04:36 +0100
Message-ID: <CAOq732+1sYnwbHXk0Cv6k2JuAW7U2eXvPMcCWwu9wBcmteS0xQ@mail.gmail.com>
In-Reply-To: <CAG17S_P3Ox7u-H_yQabqQsopHzDNGtnSHxH-QQrnxLPBG01Tcg@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3235620124588048460==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Keith,

On Sat, 12 Dec 2020 at 20:53, KeithG <ys3al35l@gmail.com> wrote:
> Wanted to post here. I recently started having issues with my Arch Linux =
install with NetworkManager and iwd 1.9 not connecting at boot or reconnect=
ing after wake-up. It used to work reasonably well then recently, after an =
update, it would only reconnect if I restarted iwd or NW after boot. I ran =
across a post to the NW project that you posted and said that you recently =
addressed an issue with iwd and NW.

Well, yes, but I addressed an issue in NM's iwd-backend code, so an
IWD upgrade shouldn't have changed much ;-)

> I built the 1.10 version and am posting here to say that it appears to ha=
ve fixed my issue. I just tried one reboot and it was already connected by =
the time the desktop showed. Tried a suspend resume and likewise it was sho=
wing the WiFi icon as connected when the login screen appeared.

I suspet you also upgraded NM?  The fix I think I was talking about
should have landed in 1.28 released last week.  In case the issue
re-appears do you recall upgrading NM or IWD when the issue
*appeared*?  In any case thanks for the report, feel free to report
new issues.

Best regards
--===============3235620124588048460==--

