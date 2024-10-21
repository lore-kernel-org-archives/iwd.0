Received: from mout-b-210.mailbox.org (mout-b-210.mailbox.org [195.10.208.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C254D1FDFB7
	for <iwd@lists.linux.dev>; Mon, 21 Oct 2024 20:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729542192; cv=none; b=Sn86Zz7yF6EpehtTSG/SqDFK40q8EEuPPQtiw2Widn8eFvySYLLOKQluQ1N97vMyIgd/tkwuksIf+IvrGbZ0DUES7LS1k1k3Uasa4vJJmfFFp/iDPlw1bmjkqL3T821UQP6ISXc1JocMVYVSbqCkcNZRIfHZqXu3vLQ1jDRDgqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729542192; c=relaxed/simple;
	bh=Lq496n01fZzvBhzWfCU6PiFtGFwGaE5GnpZVjaFfNWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YihN3Xs7NU2ct2EOoo0wK2H7bQRxj2uAxN5voYNOVhunaB/HxxQdJ32s0+L+8gU+bqq1sEgUcO3RkmkcctZaLPSWDoCVarhL89brPc5QO3WC8FHwlX7fGiftJsSw7fJtI4OYXwoUMahwKZpRTWmuoG6u0Q9RK4FYm8pI4ai8IFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de; spf=pass smtp.mailfrom=tavla.de; dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b=fbksdQnb; arc=none smtp.client-ip=195.10.208.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tavla.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b="fbksdQnb"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4XXRZd1lH6zDtqS;
	Mon, 21 Oct 2024 22:23:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1729542185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YOL2h20e8KO0xSCFn8Osg0fbfbeguT/uzQaUMCObd4s=;
	b=fbksdQnbgEAf5I2HxwWw5zR2d6muRGupzeN9JgfMfUAg+WZcJD20tmIiebYeZClXsdcDh8
	sY1i9w7l/oK4+SXQAVndKpa06zrlOpGibiH7GkW1j/Bzf1+KUFtpHCKWqoln7TKgYqVhnT
	J3o58zoOJ3e+uD6R3+idziVC/47MjqIQzQ09Q70Rh4ZFs5lfqBYT3MfrkY/veN+1qTug5d
	NSTccjmf8jIm14r9TcbcJwm1uGbu6/L2t99QUZrMevXkBrg6SukY9bNqmHc6F4/n7MTV70
	tj1pvvkW9Oal/62rwCSJ7twyBoBpJHKwvTAAUyexDDsWgdxP8ALvode5F3/Ygg==
Message-ID: <c432d58c-d0a0-4887-8b95-01a65bf096d6@tavla.de>
Date: Mon, 21 Oct 2024 22:23:03 +0200
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

I have now used the eval board (same kernel, different firmware). Is 
this possible (nothing there):

----------

root@imx8mp-var-dart:~# cat mykernel.config | grep CONFIG_DEBUG_KERNEL
CONFIG_DEBUG_KERNEL=y
root@imx8mp-var-dart:~# cat mykernel.config | grep CONFIG_DEBUG_INFO
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_INFO_NONE is not set
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
root@imx8mp-var-dart:~# ls -l /sys/kernel/debug/ieee80211/phy0/
insgesamt 0

---------

Martin

