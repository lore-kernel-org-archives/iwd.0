Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04DC1F942E
	for <iwd@lists.linux.dev>; Mon, 21 Oct 2024 19:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729537866; cv=none; b=k4lvfnKZC3QQXYnQRQ95iLRfCZufj9n0AcC6+FaPvhRO64YBVWs2DennYGXZ6DG4OMgebr8uL+SvqkncXBY6wBgzwM/mvrzZdLgG5O+aLiE8s1n0M9MZOA802a1JZrzApPtn9T1XKx1U8TULWrNqmjqcfpUz0VyXxvWzCJB5TBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729537866; c=relaxed/simple;
	bh=irD+y4uiEgpl+tbKVr0hlxWAMzwABM2jcbwIujvambs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iDzSLTydIHHQ/HSzumSrhahiY+rY2b/bAwfGhkWXtrSD7OwtBsZwNuXKxS4/0qB3nM3PKRui3+td9Z0fFksSBGjs8I0/9nndOcxjRIbXZTuyBJX9EuZwYF90WffiWCSGwNAVBZ0CtL3zcyGM4/44aIoOvz+GEfTHb2haphcefZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YuX3RGSs; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YuX3RGSs"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b149ef910eso405934185a.3
        for <iwd@lists.linux.dev>; Mon, 21 Oct 2024 12:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729537864; x=1730142664; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YWthGB6i9ll5JFe9Bfo6Uu48wMxIh6+jdPUwj1NaR4Q=;
        b=YuX3RGSsCNZCWVMT6IWUHb26cLScWpBGibji2XsskeQ2ncS6wGSAt8bf1HQ78xEIVu
         IQDGxO+njzHKxRxGp6g42t9+fhatfYxonalNPUxS0Z63Ib0zhwmza8vxBLw2QkBU/tYI
         KtBjNFiNIIxU3RMUy0DSj1NUJ9oY1mov2syeeoNS9VctyG9Fn7Yl26Dvmt7FRvuT8h3B
         svE//NeSGLbP/SELX9Zz1H+tgRuGzFRNdxOF+4HQN2rFPLCTX3leX/4PZskPf/4fRC5d
         bmSoLfgq9PnoCGaZ+B45XqHCXACEH+IqoRZOkZb7tPNsw8xiIgdF3ojDPOPZImClsSJC
         dasA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729537864; x=1730142664;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YWthGB6i9ll5JFe9Bfo6Uu48wMxIh6+jdPUwj1NaR4Q=;
        b=sn8vamuaIarKRS5YdnajfZCPfbKYKx5bnDFuaO1qM7K9mbVZOgyG10/2taK+fA/odS
         nBJEELVqVU/LsKxCoywlXKpfwbg4br5TnOhpi8pZzIPOndO5Ngm0l1FbBE/TVRvyVqP5
         FbrYfTxy5bI5lmqqWE38y+MeC4MJcKGHHvrEM3g4SNa9m8aYsHWrX3Qdh+YK3r4SYrNK
         vtuQi1YzRS7zF2CiKQ28UMMM2Ed/MUNbPCiIv+7W5Z/YA0DnRppMO2rMJDP0t/MuuIa2
         idH4D8CeKZYiJsk6KHAw/fzXy2c2KCjfaL9luGpZHNdQHs2kILg+tWCjiD+ZI+HtMmqp
         ed8w==
X-Gm-Message-State: AOJu0YynAEGJu9lSzyI7AT0YEnlhj7PWgnN66ZGlOoF3A/ILAAiEk0Zw
	TUPQGdpA7iGOZwmDAPC5OQPD4zCI3fNRQCTUxNtABBRg2CD3fq6X
X-Google-Smtp-Source: AGHT+IEi7071SkorguYnjvz2qF+STdJZ9kPRtDbZ2cYxMtsePlyd4JlPVPKPwHB/ukcG1r4ajglN6Q==
X-Received: by 2002:a05:620a:4687:b0:7b1:3e41:849f with SMTP id af79cd13be357-7b157bdbeb9mr1783019385a.47.1729537863526;
        Mon, 21 Oct 2024 12:11:03 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b165a883f1sm196753485a.130.2024.10.21.12.11.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 12:11:03 -0700 (PDT)
Message-ID: <494b8be3-8094-446f-9b96-b06debbbeac6@gmail.com>
Date: Mon, 21 Oct 2024 12:11:01 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: IWD 1.27 with brcmfmac not working for roaming
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
 Denis Kenzior <denkenz@gmail.com>, Martin Petzold <martin.petzold@tavla.de>
Cc: iwd@lists.linux.dev
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
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <c57706f6-2d5c-4e73-bc42-e2b7e4239a78@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Arend,

On 10/21/24 11:26 AM, Arend van Spriel wrote:
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
>
> Regards,
> Arend

Maybe its just a naming issue, but is "sae_ext" only relevant for SAE? 
Not OWE? So would CMD_EXTERNAL_AUTH even matter in this case?

Thanks,

James

