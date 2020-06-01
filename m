Content-Type: multipart/mixed; boundary="===============2661834289647551960=="
MIME-Version: 1.0
From: Alvin =?unknown-8bit?q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>
Subject: Re: [PATCH] scan: don't send the same scan request twice
Date: Mon, 01 Jun 2020 19:12:23 +0200
Message-ID: <9741a7ac-1870-58cc-c416-9c526ecfd288@bang-olufsen.dk>
In-Reply-To: <CAOq732LFMpVzcGGEvuXjXWgXOTRzSQPOzBoDNLNHZRNQURZpCg@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2661834289647551960==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 6/1/20 3:20 PM, Andrew Zaborowski wrote> It would probably work.  The
downside is that we're possibly
> re-checking conditions that we already know are fulfilled, the upside
> is possibly readability.
> =

> You'd then need to change the commit message to say it's refactoring
> start_next_scan_request.

I will send a v2 patch with an updated commit message addressing your
comments:
 - NL80211_CMD_GET_SCAN -> NL80211_CMD_TRIGGER_SCAN
 - mention that start_next_scan_request() is being refactored

>> I'm not quite sure what the reason for this is, but maybe you can commen=
t?
> =

> The reason is that the scan_passive, scan_active, etc. entry points
> are not assumed to call the destroy callback synchronously. When they
> return an error it's assumed that none of the resources passed as
> parameters were used and no callbacks happened, i.e. funcions have no
> side effects on errors, afaik it's just a convention.

OK, I understand. Considering that (reasonable) convention, I guess it's
not a good idea to have scan_common() call into
start_next_scan_request(). Please disregard my suggestion.

Please check out the v2 patch I have posted. I also added a second patch
to check for sc->suspended in scan_common(). You can take it as well if
you think it's needed.

Kind regards,
Alvin
--===============2661834289647551960==--

