Received: from mout-b-112.mailbox.org (mout-b-112.mailbox.org [195.10.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B774D1E2846
	for <iwd@lists.linux.dev>; Mon, 21 Oct 2024 22:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729548635; cv=none; b=X8KIwnW1eQprF6er25EbJOpR1CFCqjPEJRN03Qcs6j6ZIzFwSF44ar9G663bxaJ3g2WsENA0J20Fz4tTaRsFPhls5jTr9F5/eRE2wYYsTGws7qR5FmiaZ6NgnYzP5cFBe0H7qpDl1sOi1BpteffS5HaIZUhY+Ur0Xp1emP7lpaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729548635; c=relaxed/simple;
	bh=//WKGdpTOf68JYiYzu1zbClLZ1M2gMfumqJNNvQlyxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iv4PJYxm/uKGGvCtZmbsNlflatAGhvh2OLfdnlldm0HYd4e+VB05Sg6V4M4w0FZcN7KNwl9Zy8UB8D829+cyW4CgY4OccbQHp5BdKNlSIEqPLvh1Nu+TDQT9JGklO9J8+hSPa5KWzLb62RHtVgcwdtnILdGoGN++NF9sghkbJmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de; spf=pass smtp.mailfrom=tavla.de; dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b=nGV/ou+X; arc=none smtp.client-ip=195.10.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tavla.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b="nGV/ou+X"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4XXTyW4G7bzDt2w;
	Tue, 22 Oct 2024 00:10:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1729548627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8wUYlF4THBY0ZjQbGyffAx9N0DfndMe4ote4Wxaxwac=;
	b=nGV/ou+XidDm2XJmHuXoEWyB/Ac0yaFnajZjuAorAiG/+iWlXQupAUtqQcDVmEq0c4Xidf
	LLY6VvCpqh7ACWtlXeaVRsQowRdES1hS31k+MDzZKwOqbIbWcCfa7Ah4N3eVvMfXrVejCU
	W974NvCLWjwUWAl9Xa8Fi0NkQi1ugR0yegbNtItlDLkP/TMsLrP5jheyvmhgwK8dPZrYfM
	Mbj9/k/PJSr4QYCLQWjv5NDFIbg7YEm2iQhF62XK1YrNXkKPrxpX4zNdWJD7Rw3ouUV2Xe
	6sQKOVjCjddGF45Z0iZvwBu8vHfVAMMSYDagHqakJYTj+qX2Fs+sQmMZO9zoag==
Message-ID: <2236075a-8239-4f1a-b878-adfd281f3dbb@tavla.de>
Date: Tue, 22 Oct 2024 00:10:25 +0200
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: IWD 1.27 with brcmfmac not working for roaming
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Denis Kenzior <denkenz@gmail.com>, James Prestwood <prestwoj@gmail.com>,
 iwd@lists.linux.dev, KeithG <ys3al35l@gmail.com>
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
 <CAG17S_Nq1BjYSzSrqMne-6-sO3HK84XEbPf72oh-GM87kd2uJg@mail.gmail.com>
Content-Language: en-GB, de-DE
From: Martin Petzold <martin.petzold@tavla.de>
Organization: TAVLA Technology GmbH
In-Reply-To: <CAG17S_Nq1BjYSzSrqMne-6-sO3HK84XEbPf72oh-GM87kd2uJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4XXTyW4G7bzDt2w

Hi Arend,

Am 22.10.24 um 00:01 schrieb KeithG:
> Arend,
>
> If there is a patch for brcmfmac to use CMD_EXTERNAL_AUTH, I am
> interested in testing. The last time we tried, it errored out and did
> not work as expected.

Support with our current chip for WPA3 and also OWE by offloading SAE 
etc. to IWD. That is possible?! This would be great!

Thanks,

Martin

>
> If the patch can be applied to the current, RPi 6.6.x kernel, I can
> test it on my Pis.
>
> Keith
>
> On Mon, Oct 21, 2024 at 1:26 PM Arend van Spriel
> <arend.vanspriel@broadcom.com> wrote:
>> On 10/21/2024 7:40 PM, Denis Kenzior wrote:
>>> Hi Arend,
>>>
>>>> I have not seen patches for OWE in brcmfmac. Looking at the supported
>>>> ciphers:
>>> OWE is an AKM.  It still uses CCMP/CMAC underneath.
>> My bad. Always confused by those concepts.
>>
>>>> Supported Ciphers:
>>>>    * WEP40 (00-0f-ac:1)
>>>>    * WEP104 (00-0f-ac:5)
>>>>    * TKIP (00-0f-ac:2)
>>>>    * CCMP-128 (00-0f-ac:4)
>>>>    * CMAC (00-0f-ac:6)
>>>>
>>>> The error message seems to match with the above.
>>> I've never seen support for OWE in brcmfmac mentioned.  OWE requires
>>> CMD_AUTHENTICATE / CMD_ASSOCIATE (or CMD_EXTERNAL_AUTH) to derive the
>>> PMK, so iwd can't support it on FullMAC.
>> I have never seen any mention of OWE either. Regarding CMD_EXTERNAL_AUTH
>> support I recently posted patches on linux-wireless list as RFT. There
>> has been zero feedback and so I assume also zero interest. In order to
>> use CMD_EXTERNAL_AUTH the firmware needs to advertise "sae_ext" in fwcap
>> debugfs file. So if Martin can check that, ie:
>>
>> $ grep sae_ext /sys/kernel/debug/ieee80211/phy0/fwcap
>>
>> Regards,
>> Arend
>>
