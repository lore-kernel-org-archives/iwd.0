Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31076A002
	for <iwd@lists.linux.dev>; Wed, 14 Feb 2024 20:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707941585; cv=none; b=gpVdkncuacNkNbfEw7N6AW5r0pzLy4Ur+kKUBCDqsX3eiH+VbMx9Z2ED2X/Wk1dPoMo3EKHDlKapaZnhMFN675Uq5MT4i3kA0ajk2n7AVdnOWqCrZ6IvWip3IsDnW2L87HuDA2ChHJ2iAVk7oCWU62SSBNINYTSN6fgMqoxRc9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707941585; c=relaxed/simple;
	bh=kt61LiEqIch5QLeqGfDueJj/FPaCCra7i8LpD6o8+ww=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=g2jTdqVgHIdKlsSxew2w5/pb6DQRr1xj6wTaTRO+hlQdnNKSswV3VzB5q2HJoUEsFylCX/5TiVawcXGPoQPe5gK33FzHwPuc7By7zoXmh+3mI1IzJywxsIIFKYIqOFlHMUCZXVAteC1aTCAwg+7iJo6LcDUGfo26/bjZHwT6Lgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org; spf=pass smtp.mailfrom=holtmann.org; arc=none smtp.client-ip=212.227.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p4ff9fa23.dip0.t-ipconnect.de [79.249.250.35])
	by mail.holtmann.org (Postfix) with ESMTPSA id A2AC7CECBE;
	Wed, 14 Feb 2024 21:13:02 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [RFC 5/5] doc: document use of l_log APIs
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <d9a38d47-e188-4e24-a397-515c0f525e8d@gmail.com>
Date: Wed, 14 Feb 2024 21:12:52 +0100
Cc: iwd@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <64099BA4-0E8F-4F0B-A8EA-47E2A94B6625@holtmann.org>
References: <20240214193743.963349-1-prestwoj@gmail.com>
 <20240214193743.963349-6-prestwoj@gmail.com>
 <1DB84D8A-74F6-43EC-9E27-A477FD343F0E@holtmann.org>
 <d9a38d47-e188-4e24-a397-515c0f525e8d@gmail.com>
To: James Prestwood <prestwoj@gmail.com>
X-Mailer: Apple Mail (2.3774.400.31)

Hi James,

>>> With the introduction of l_notice in IWD some guidelines need to be
>>> set for l_info, l_warn, l_error, l_debug and l_notice.
>>> ---
>>> doc/coding-style.txt | 24 ++++++++++++++++++++++++
>>> 1 file changed, 24 insertions(+)
>>>=20
>>> diff --git a/doc/coding-style.txt b/doc/coding-style.txt
>>> index bf0535c5..fdd9e0e3 100644
>>> --- a/doc/coding-style.txt
>>> +++ b/doc/coding-style.txt
>>> @@ -317,6 +317,30 @@ Functions that are static should not be =
forward-declared.  The only exception
>>> to this rule is if a circular dependency condition exists, and the =
forward
>>> declaration cannot be avoided.
>>>=20
>>> +M18: Use appropriate logging levels
>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> +An appropriate log level should be used depending on the type of =
message
>>> +being logged. Logging is done using the l_log APIs in ELL:
>>> +
>>> +l_info    Information that is expected during normal operation. =
l_info's use
>>> +          should be very limited so non-debug logs are concise
>>> +l_warn    An unexpected, but non-fatal condition ocurred
>>> +l_error   An unexpected condition ocurred. These are generally =
fatal to the
>>> +          current connection/protocol that is running but not =
generally to IWD's
>>> +          overall operation.
>>> +l_debug   General debugging. These can be used relatively freely =
but should
>>> +          provide some piece of useful information.
>>> +l_notice  Reserved for specific event-type notifications about =
IWD's internal
>>> +          state. These are logs that are mean to be both =
human-readable and
>>> +          parsed by tooling so they are required to be of a certain =
syntax. They
>>> +          should start with "event: <name>" followed by comma =
separated key
>>> +          value pairs containing the data of interest. Event names =
and their
>>> +          arguments should be consistent across the code base, i.e. =
two events
>>> +          called in different locations should have the same =
arguments.
>> and now they are not even in order of their log level. That confuses =
people.
> You mean just the order they appear in this document or using l_notice =
for this purpose in general?

the order number / priority they have in reality according to syslog.

>>=20
>>> +
>>> +          For example:
>>> +
>>> +          l_notice("event: mycondition, arg1: value1, arg2: value2, =
...");
>> Please no semantics for the freeform text. If you want that, then =
better build some proper iwd_log functionality that does that.
> The intent was to use l_notice only for this purpose so I felt =
describing the specific semantics was appropriate. I can remove the =
example but since the intended use is very specific and has some syntax =
requirements I think describing those here is needed.

If you want something like that then lets enforce that with iwd_log or =
iwd_notice helper and not via some one line example in the coding style =
document.

Regards

Marcel

