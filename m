Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B2A1F92C
	for <iwd@lists.linux.dev>; Mon,  4 Mar 2024 21:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709588413; cv=none; b=lKzUmyXNix7L7n59s30jWiw7FGszWJpfo32ofbf1rlbr1TWw40sjVlg3zhOmCLJdQ7Nbn1zqJ0Pt+aLUv2lh3x7hUw3AWKDdU5NZp8iBsDvAKv6fTG9j1veNPFcjcr1J55ioS33NlKII6CqGrixTMBVladuOmdaGjMemGJvk1HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709588413; c=relaxed/simple;
	bh=obF/LQ7vz9poYYeQbtqr+iW+kXojiPpqzRp4P2WWpfQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=WAVOMsGsRFSBvgRQqr9xA9r19/WyPW2G9ive56R7PdmRqOSAYOD624rXXluhyPQluT4reDaasSKopDZYWqwaX2dXkwE18itTHT67jB2nqrpAMdq4ddTEmJOuHRUPyZLSSzz6oze4KA/ORx1vr3vv18fkbsy9+5FNRikCzRY1LT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=H25poPUB; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="H25poPUB"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 9ABB41649AB;
	Mon,  4 Mar 2024 16:40:09 -0500 (EST)
Received: from [192.168.1.128] (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 353B0124F0E;
	Mon,  4 Mar 2024 16:40:09 -0500 (EST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: IPv6 Privacy Extension support?
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <20240304193253.GA25@magnesium.vonhaugwitz.com>
Date: Mon, 4 Mar 2024 13:40:08 -0800
Cc: Hannes von Haugwitz <hannes@vonhaugwitz.com>,
 iwd@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <BBC776B8-57F8-460D-A1CC-FD3B5A522311@nuovations.com>
References: <20240301144608.GA25@magnesium.vonhaugwitz.com>
 <629785cf-77c3-4b14-ab58-d4b2c75f254a@gmail.com>
 <20240304193253.GA25@magnesium.vonhaugwitz.com>
To: James Prestwood <prestwoj@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=content-type:mime-version:subject:from:in-reply-to:date:cc:content-transfer-encoding:message-id:references:to; s=pair-202401062137; bh=O5ycZNJEXbd9uL4v+fujUsc6CNyIPHB5wENI6wJhsHQ=; b=H25poPUBTtywYNDbO2BuNQXATPoeY5o8F6K10nWNJR9ziAODlxKFEvBHYEmiuUq19KGMN2ERy17JEJa9i9Lqc3kJlBwyuGjVTs0vivnDGHIjpB/FHJ+Tmwm2INJTYy7KgsKXPQRo7+G6o50psjxFvqV7hZqPc1QXdUPBNRMWxhLlJFC8QaFWdnwfjC8/WBiVkAy3z1rC2VCau9f5LEUKWCMCoVhTUTcBU0vatWSpbXEu9zEku52JjJtyU41RujGkt6G/82MP+xzGYg/fxdcL/qE5iJvLP8HE01YrgIy33Nf9mC33ZnTZAMn8TJR40OSwyDFFKDu9ikhWO9rm8FLtKQ==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

On Mar 4, 2024, at 11:32 AM, Hannes von Haugwitz =
<hannes@vonhaugwitz.com> wrote:
> On Mon, Mar 04, 2024 at 04:30:27AM -0800, James Prestwood wrote:
>> I'm not familiar with the privacy extensions specifically, but you =
can
>> enable MAC address randomization which should hide the MAC for you. =
You can
>> check the man pages for more details but in main.conf something like:
>>=20
>> [Settings]
>> AddressRandomization=3Dnetwork
>=20
> MAC address randomization hides the physical MAC address but does not
> prevent device tracking (within the same network). With privacy =
extension
> enabled, the IPv6 address is randomly regenerated every few hours.
>=20
> For more details see [RFC_4941].
>=20
> Best regards
>=20
> Hannes

James:

I believe it=E2=80=99s handled in connman with these APIs:

    =
https://git.kernel.org/pub/scm/network/connman/connman.git/tree/src/ipconf=
ig.c#n528

with the Linux kernel =E2=80=9Cuse_tempaddr=E2=80=9D sysctl setting. I =
assume iwd would have to replicate this infrastructure, or pull it into =
ELL and share it that way.

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/

