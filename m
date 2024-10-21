Received: from mout-b-105.mailbox.org (mout-b-105.mailbox.org [195.10.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32CD173
	for <iwd@lists.linux.dev>; Mon, 21 Oct 2024 18:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729536353; cv=none; b=WcD/phE+RtTJMzwZfxUQevBoxbLXKyW2MH18dhLMQPN1z5dIA5wDjvVE0vWfvBjkAIpyKmw0uRHXzaAtBLEV4t77t2Rhu1MmnPtgINi5+XQ5GnAK/3K93kcl/bpT5bzFaGwO/LjuWljfOF5xzcBMlWkMsXmOWgU8gJ+O0KW5/pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729536353; c=relaxed/simple;
	bh=YDKQ1qfHwFa12nY6sKWLR9vjMmdmcJN0ZJdQP5a9XxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hQCR3INA+7V+J/ommINuOq9dg2wS9McAoeHYjCSUJlp0gsg0mIflgUK/a+Lcweeyp+PJNsd5VvU5M/h2exgjTHn5ttxileJbRj5XSk0W9YX6y3sPmTw6gP0/xaysg8rX7WQGfD4cMLOzIFzHVdIUBr6j1B6Otq0tt+KB1O91Esc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de; spf=pass smtp.mailfrom=tavla.de; dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b=uN2n8qF9; arc=none smtp.client-ip=195.10.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tavla.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b="uN2n8qF9"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-105.mailbox.org (Postfix) with ESMTPS id 4XXPQK6CFfz9vYx;
	Mon, 21 Oct 2024 20:45:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1729536345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z8/G/IKteDI5nRPURF9bdzHBdFmN8IrTwz0GaHzAQnc=;
	b=uN2n8qF9fvUloGevJbRQPZ3m45bYyZ0XHL5TSp38MIGofrv0RPLGzhNRBhwQebcCzMvojZ
	tfNoo7xgggEP8ibzxk5DrHZoxy9Ct/zSYur7zSvwt5+JsURjONkT2m0nSDXgcanTYLgRcJ
	NeZX/WKIJNKwAVNHq3VpHWmtS/W+GKGOVzAZvbDj+pE5Nf0QJGU1p96OBUjvydXwm1fNOV
	kpQEc8gKe2oIs/UNz+lIWkAMZ4+e96KAKXYePM2jmN8oyk5+y2H1lRbJG5tIZ/8T6cHh+u
	NwmpgveX5MFhq9++IR9WWJGyQ6jXG8ipbaEbyiyx9UKKTNsXJbx/attnbgk4zg==
Message-ID: <23e1e0d2-52ba-46eb-8159-0645f4530769@tavla.de>
Date: Mon, 21 Oct 2024 20:45:43 +0200
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: IWD 1.27 with brcmfmac not working for roaming
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: iwd@lists.linux.dev, Denis Kenzior <denkenz@gmail.com>,
 James Prestwood <prestwoj@gmail.com>
References: <a99e0ef1-8f97-4c1d-9aa5-5a07c87782a5@tavla.de>
 <d91f33df-e9d7-430a-b1ca-13cd1dee973a@gmail.com>
 <c5e790a5-2854-47a6-9431-e02a0f9e6676@tavla.de>
 <5efc11fc-9c21-44a0-b282-5d41bfb96a8c@gmail.com>
 <f496ad63-e2a6-46cb-b7d6-1a084523c7d9@broadcom.com>
 <1761198e-9f41-4e5a-b2b9-a1652732346d@gmail.com>
 <6898cd84-c7b9-4fa0-aeb5-c7a90d81b58b@tavla.de>
 <b0afc4f1-6496-48a4-a11c-789ee08368e4@tavla.de>
 <5a128900-432f-439e-9008-3b303ee72eb1@gmail.com>
 <2dacc589-9927-40f7-85ed-5f6b2afbbd41@tavla.de>
 <192af85f1e0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <2ab8601e-1601-4d4f-b58d-e9f23877650f@gmail.com>
 <192b00cf460.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <54a62c50-5c9b-47c6-b8ab-f7369381fdf9@gmail.com>
 <c57706f6-2d5c-4e73-bc42-e2b7e4239a78@broadcom.com>
Content-Language: en-GB, de-DE
From: Martin Petzold <martin.petzold@tavla.de>
Organization: TAVLA Technology GmbH
In-Reply-To: <c57706f6-2d5c-4e73-bc42-e2b7e4239a78@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Arend,

Am 21.10.24 um 20:26 schrieb Arend van Spriel:
> On 10/21/2024 7:40 PM, Denis Kenzior wrote:
>> Hi Arend,
>>
>>>
>>> I have not seen patches for OWE in brcmfmac. Looking at the 
>>> supported ciphers:
>>
>> OWE is an AKM.  It still uses CCMP/CMAC underneath.
>
> My bad. Always confused by those concepts.
>
>>>
>>> Supported Ciphers:
>>>   * WEP40 (00-0f-ac:1)
>>>   * WEP104 (00-0f-ac:5)
>>>   * TKIP (00-0f-ac:2)
>>>   * CCMP-128 (00-0f-ac:4)
>>>   * CMAC (00-0f-ac:6)
>>>
>>> The error message seems to match with the above.
>>
>> I've never seen support for OWE in brcmfmac mentioned.  OWE requires 
>> CMD_AUTHENTICATE / CMD_ASSOCIATE (or CMD_EXTERNAL_AUTH) to derive the 
>> PMK, so iwd can't support it on FullMAC.
>
> I have never seen any mention of OWE either. Regarding 
> CMD_EXTERNAL_AUTH support I recently posted patches on linux-wireless 
> list as RFT. There has been zero feedback and so I assume also zero 
> interest. In order to use CMD_EXTERNAL_AUTH the firmware needs to 
> advertise "sae_ext" in fwcap debugfs file. So if Martin can check 
> that, ie:
>
> $ grep sae_ext /sys/kernel/debug/ieee80211/phy0/fwcap
tavla@tavla:~$ grep sae_ext /sys/kernel/debug/ieee80211/phy0/fwcap

grep: /sys/kernel/debug/ieee80211/phy0/fwcap: Keine Berechtigung

Do I need to enable kernel debugging in kernel configuration? (takes a 
little time - possible without re-build?)

I'm very hard under pressure, the customer needs some result tomorrow. 
Is the problem clear now? Any work-around?

Thanks,

Martin

