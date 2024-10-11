Received: from mx2.sew-eurodrive.com (mx2.sew-eurodrive.com [194.180.1.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DE9188CB1
	for <iwd@lists.linux.dev>; Fri, 11 Oct 2024 15:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.180.1.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728661417; cv=none; b=Nu9Jgo2gZm3jqLyuw1gRIQJvnVxM0owgta2NLLqKf0Cb88ugdmqk0U+vnDbVj4Rhbj3b7KVLDyEMMC7Xjls36camI6rtoWWaoCctu5u1E0YAbPUK8shvEY3/NiDnqJzNX4QQRCmYHXmowr0IrCK5E9bSU9m0oBRXcS3MaUL+bDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728661417; c=relaxed/simple;
	bh=2vTvwx1rYVSvEaGa84LxLA0CSDjn6bscICXoTwxFNUY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=S/yulwM4UUvY/lvA/bKQi7MUmrgCXTZtsoo+Yb6DiSgI00cLCd3+FF78O21pjCQWBQNRqC/yLemftIMZlxC/+Mt34ujRpa5SySTj1J3g3boleG1fUUWnSID/hVsuvWiHc4tIcg+aM7JK2cbfqHBFqL24Bfdr7NiDznFDo/THSJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sew-eurodrive.de; spf=pass smtp.mailfrom=sew-eurodrive.de; dkim=pass (2048-bit key) header.d=sew-eurodrive.de header.i=@sew-eurodrive.de header.b=joxihUog; arc=none smtp.client-ip=194.180.1.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sew-eurodrive.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sew-eurodrive.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sew-eurodrive.de header.i=@sew-eurodrive.de header.b="joxihUog"
Received: from pps.filterd (mx2.sew-eurodrive.com [127.0.0.1])
	by mx2.sew-eurodrive.com (8.18.1.2/8.18.1.2) with ESMTP id 49BAZGFq016496
	for <iwd@lists.linux.dev>; Fri, 11 Oct 2024 17:32:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sew-eurodrive.de;
 h=content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=sew1;
 bh=2vTvwx1rYVSvEaGa84LxLA0CSDjn6bscICXoTwxFNUY=;
 b=joxihUogEGzXXwVyAzG3RzfMs0MSa2VRfkuse8KXI5wq1o0ZiE3vLBFEREPrlagvWGg8
 /IjO6gsxMQbPrKCI+4bOhDEuBKYH15d/FeuT3RB989+BAsOi+rxIs96/gDqalMMFtKgL
 kRZGfWPprsESPFm148f0L4Zek4pSBMKk8c3TOSYfJharjx4tADYxoLZTswgbCsFa99Nq
 CcjaTl0XEwusCTQIbyTYRncVwaJotc8BNP4BA/5JcZn9RmZAGohTG+7d0gLkyqru3NwQ
 rWBmfVoq0hNhmQnyaEhCge9atzuFJeiVqRzKO5WYB/lpktOolS06CPlIgCNqUaT5zXlt sQ== 
X-PGP-Universal: processed;
	by brudepgp2.de.eu.sew on Fri, 11 Oct 2024 17:32:29 +0200
From: <Dierk.Modrow@sew-eurodrive.de>
To: <prestwoj@gmail.com>, <iwd@lists.linux.dev>
Subject: AW: AW: IWD 2.20 does not support Fast Roaming with NXP 88W9098
 chipset
Thread-Topic: AW: IWD 2.20 does not support Fast Roaming with NXP 88W9098
 chipset
Thread-Index: Adsa51JuwNri5SA8SMa+fbi0XqaCYwACprlQAABF/rAACglzwP//6BcAgAGb/gD//9UTwA==
Date: Fri, 11 Oct 2024 15:32:27 +0000
Message-ID: <956c6b2729d848ea81c363cfac43dc13@sew-eurodrive.de>
References: <5c65040719764a49a48846ea11c535a7@sew-eurodrive.de>
 <c477b2d9-dcc7-4ea7-a6b1-47f6f84e4736@gmail.com>
 <1565c790-83d9-4972-b0dc-e9f575bc8d93@gmail.com>
In-Reply-To: <1565c790-83d9-4972-b0dc-e9f575bc8d93@gmail.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-organizationbypassclutter: true
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OLX-Disclaimer: DEBRUMSX23.DE.EU.SEW
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-11_13,2024-10-11_01,2024-09-30_01

Hi James,

thank you for the patches. I will try it as a first workaround.

Thanks,

Dierk

Von: James Prestwood <prestwoj@gmail.com>
Gesendet: Freitag, 11. Oktober 2024 16:58
An: Modrow, Dierk <Dierk.Modrow@sew-eurodrive.de>; iwd@lists.linux.dev
Betreff: Re: AW: IWD 2.20 does not support Fast Roaming with NXP 88W9098 ch=
ipset

H Dierk, <snip> >> I also added a sorted log file containing iwd traces, iw=
mon text logs >> and kernel msgs (of the NXP driver): >> resorted_logs_of_i=
wd_ft_connection_trial#3.=E2=80=8Atxt >> >> >> We would like

H Dierk,

<snip>
>> I also added a sorted log file containing iwd traces, iwmon text logs
>> and kernel msgs (of the NXP driver):
>> resorted_logs_of_iwd_ft_connection_trial#3.txt
>>
>>
>> We would like to use iwd instead of wpa_supplicant so any help would
>> be appreciated!
> At this point in time looking at the above logs it appears IWD isn't
> compatible with this out of tree driver due to the requirement to use
> CMD_AUTHENTICATE. I've thought about adding this back in for "weird"
> drivers that have problems with how IWD works. For the near term we
> could try and detect this case, via the CMD_REGISTER failure, and
> disable FT entirely for drivers like this. You'd be stuck with only
> reassociation but at least the device could roam. I can get you a
> patch to try soon.

I just sent a few patches to the mailing list. Would you be able to try
these out and verify the device roams? Note, its going to choose
reassociation now (if they work as intended), not FT. But any roaming is
better than nothing at least. Longer term we can think about using
CMD_AUTHENTICATE for drivers like this.

Thanks,

James


________________________________


SEW-EURODRIVE GmbH & Co KG
Kommanditgesellschaft, Sitz: Bruchsal, RG Mannheim HRA 230970
Komplement=C3=A4rin: SEW-EURODRIVE Verwaltungs-GmbH, Sitz: Bruchsal, RG Man=
nheim HRB 230207

Gesch=C3=A4ftsf=C3=BChrender Gesellschafter: J=C3=BCrgen Blickle
Gesch=C3=A4ftsf=C3=BChrung: J=C3=BCrgen Blickle (Vorsitzender), Dr. J=C3=B6=
rg Hermes, Dr. Hans Krattenmacher, Christian Mayer, Johann Soder
