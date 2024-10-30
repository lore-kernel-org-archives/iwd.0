Received: from mout-b-105.mailbox.org (mout-b-105.mailbox.org [195.10.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA542215005
	for <iwd@lists.linux.dev>; Wed, 30 Oct 2024 20:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730320729; cv=none; b=UIU8Xdh4KqtHSArl+BwUz8K4YCvF8/WxeZcdGyMLNQKuZVyCpCAug6ukI7OSPzopR92uf6+jcMuDWxVuZVoY0EQJdC4LlnGN28B9rxQDkR3Me55hNxAT4bVX7vUD/NxCMedl1rMTB8QDJYlXCovMvVtBTWnEJaTwQR/9Telc6sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730320729; c=relaxed/simple;
	bh=a3MKPFVNkWc6OuIrk6ZUhGQ8gMBh4efqKFv1Oz5CRHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pAP3PtJgaPdalDdQw2NVuGedK7hBh+nz1cVoSH242KL1TFVa9xbag7aAEiXanVp9zhO7DPPX1XZEXl/48Tli6jSugCDFFIv7VHCZ2dKAu2Cuap+HP3rXkd6JX4wWtYJxQI/rnfvtfCq8xNgoBI6nJcecWkghv7+DZH0FxapLOrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de; spf=pass smtp.mailfrom=tavla.de; dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b=R3sDTOoF; arc=none smtp.client-ip=195.10.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tavla.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b="R3sDTOoF"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-105.mailbox.org (Postfix) with ESMTPS id 4XdzVN4tf6z9vV4;
	Wed, 30 Oct 2024 21:38:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1730320716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/sIUFu4cezrBihfKSbnoD8UBWeYKbprPJRmey361B+w=;
	b=R3sDTOoFaQI1Oecu0clcTVCkJwayGEnWlhkhCzQHEFB66IiJtTfsAyTwMziB8y9T5W0scP
	7xbwHvwY+XqV+NHo59oKH4Ftjub/g/v66EHp3ngUMuS4w6uvps4UgmOFMriiX64/4ElScS
	tyDghNwSLj/0ZSkAJnIWZ2G1KPCUnQOJKkpQhH8/N6CM2Olc1PlVQ/17qwAvLG8JG6C0zp
	TU6BDY696hFnStg7j2V7OvdJUOZ6avZ1kMjyUsGjzLWCzdD4iSE9P+JjgKknkLZTCL7Daj
	YA8WQ9FgFOpK2VXUQg2u26whRNSknqlnPnokK6I+5OvsDAg9Z5ubc/wCvJmb5w==
Message-ID: <6c1776f4-2b05-48a4-aca3-b9f10a68659e@tavla.de>
Date: Wed, 30 Oct 2024 21:38:35 +0100
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: How to disable power save (iwlwifi / brcmfmac)
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
References: <3650c0e9-6d4e-45bb-ab44-ce5849d3ffe1@tavla.de>
 <bc387186-dbd6-4ab3-adfa-2a8d0f7bcc71@gmail.com>
 <629def8d-2c7b-483c-8e2d-d73467a14486@tavla.de>
 <b134a703-6747-4b1a-a022-b61f7e282bfa@gmail.com>
 <5e9122b7-dcee-4e98-8b8f-9c623276a5db@tavla.de>
 <a68ea32b-e960-45cc-9e2b-193e624908aa@gmail.com>
Content-Language: en-GB, de-DE
From: Martin Petzold <martin.petzold@tavla.de>
Organization: TAVLA Technology GmbH
In-Reply-To: <a68ea32b-e960-45cc-9e2b-193e624908aa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

Am 30.10.24 um 21:35 schrieb James Prestwood:
> Hi Martin,
>
> On 10/30/24 1:26 PM, Martin Petzold wrote:
>> Hi James,
>> However, on the Intel machine I also wonder why the following doesn't 
>> work also:
>>
>> -----
>>
>> tavla@tavla:~$ sudo reboot
>> [...]
>> tavla@tavla:~$ cat /etc/modprobe.d/iwlwifi_power_save.conf
>> options iwlwifi power_save=0
>> tavla@tavla:~$
>> tavla@tavla:~$ sudo iw wlan0 get power_save
>> Power save: on
>>
>> -----

Here is the solution for the Intel wifi chip (it seems there is some 
newer firmware and something changed):

tavla@tavla:~$ cat /etc/modprobe.d/iwlwifi_power_save.conf
options iwlwifi power_save=0
tavla@tavla:~$ cat /etc/modprobe.d/iwlmvm_power_scheme.conf
options iwlmvm power_scheme=1
tavla@tavla:~$
tavla@tavla:~$ sudo iw wlan0 get power_save
Power save: off

