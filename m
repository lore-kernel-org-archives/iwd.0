Received: from mout-b-210.mailbox.org (mout-b-210.mailbox.org [195.10.208.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD843194A7C
	for <iwd@lists.linux.dev>; Mon, 21 Oct 2024 19:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729538129; cv=none; b=TxZYcKjrho4eXIcCslo69TbiLX69oFJjpOaRbmwBtt+FH49rEBuiNGudoyuMzFfREWHfJ9+q2VbIErkKYtq9qIWauCrnOHy5EYGTqdO6agvkd38Q3oca+4mZutd4lsiBus9+RBnwhibsheN/+WGSH4u9/R/DKJui8WZstGQZ13o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729538129; c=relaxed/simple;
	bh=fHmLqr8Enj/0NUuMc8bHk1G2oP50oLYUUw9xjt+ongo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a7azT/DuWJGFhkPZdWS9aima0Ci7vMETGB0hAR4/evqPU4KfuuSPwQtNqRPTP1Y4pGEc3aGXhPhxDSK3zuZrhw6nrrODUJYHezmU2Attr/DHMOkdzjWbEEWWEDNHvmKFSFOSVVPLiXKKAEZKJKndIDzOYYtnAYGWjYom3teaflU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de; spf=pass smtp.mailfrom=tavla.de; dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b=YjykMigH; arc=none smtp.client-ip=195.10.208.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tavla.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b="YjykMigH"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4XXQ4T5ZP7zDtxd;
	Mon, 21 Oct 2024 21:15:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1729538121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GRTji+XK+pGX0wJKZCgG0SyUUDYUJM320FAnHOZehas=;
	b=YjykMigHhAA5814t9Y/2pQ6LFzcab83JpAk4FDClC69PFkfXrpbL1TWN0DYPqMV21GgXkv
	39YUUssCR/WyfJl/TXrsk4O3cVL5i3tVKTOfoH5g6Lki1fzNiJWI2B/s/TyVzlxU7DE0l3
	tDaVKkc8XeuQznHuxdg0GuBCo0mwxGtdD1aM9P/r+HXo56gybz33d6/gTaZVpptBfcB74x
	/99yvaZu2X+lqr7Iv0zJyx+JPO+nEVMZzlox0Ln4dBzBXBI+2+7X7DnRA/RmwVs9J7xOvl
	15RQbO68PbQ0KuaFBsz6Ir454toa7R/+BFIr0EZ6CUAi1N0ivlFBbP80Oi0UaA==
Message-ID: <a2b79fd9-fa4e-4270-b5c8-4a3c726416c4@tavla.de>
Date: Mon, 21 Oct 2024 21:15:20 +0200
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: IWD 1.27 with brcmfmac not working for roaming
To: Denis Kenzior <denkenz@gmail.com>
Cc: iwd@lists.linux.dev, Arend van Spriel <arend.vanspriel@broadcom.com>,
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
 <db8b9660-3e68-4223-aa3e-e3d6a7d18906@gmail.com>
Content-Language: en-GB, de-DE
From: Martin Petzold <martin.petzold@tavla.de>
Organization: TAVLA Technology GmbH
In-Reply-To: <db8b9660-3e68-4223-aa3e-e3d6a7d18906@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

Am 21.10.24 um 20:55 schrieb Denis Kenzior:
> Hi Arend,
>>
>> I have never seen any mention of OWE either. Regarding 
>> CMD_EXTERNAL_AUTH support I recently posted patches on linux-wireless 
>> list as RFT. There has been zero feedback and so I assume also zero 
>> interest. In order to use CMD_EXTERNAL_AUTH the firmware needs to 
>> advertise "sae_ext" in fwcap debugfs file. So if Martin can check 
>> that, ie:
>
> Any suggestions for hardware I can buy that I can test the upstream 
> kernel on easily?  I don't have any brcmfmac devices besides the RPI5 
> and that uses a totally different kernel. 

This is the one I am using (however, all data given is from our custom 
carrier board):

https://www.variscite.de/product/evaluation-kits/var-som-mx8m-plus-nxp-i-mx-8m-plus/var-som-mx8m-plus-evaluation-kits/

But you need to order the SOM v1.3 because with SOM 2.0 they SWITCHED to 
NXP IW612 WIFI+BT wifi chip (no comment).

Martin

