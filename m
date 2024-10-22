Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7371E515
	for <iwd@lists.linux.dev>; Tue, 22 Oct 2024 18:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729623180; cv=none; b=KihJM6da6lePye5a1c1V+JeMuTtr3Y98IWgvJSDjFM4lrqgPQMbc38SRRM7vYXs3s5a1SqBnmFAjoTSZ5qu9rQFof93pbvJv44PIRR77IHXcOuHaeEd2zs+EEq1OQKoc4+Pp0kgoWeTf+eFPEL71b3RghYcq39TH2wWc160lhJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729623180; c=relaxed/simple;
	bh=Gjxrta9zN+QxkcwolPH9xLgTOAUZmOkw2KYvxzCX3Fc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TjUNj5iYj/xso7U6+7vBvtoChbrmS+VRp4gE4iAQtDhOZ7aWNmOy0fYt0fwk1f3ABEeQ7XN3B0MVdvHk0FWe7eRAwgghABq65uBNRLjfPR+rP+DMLzWRJFLPHIhbSEIQYh3sAqFwlk+LTcSOO2nRMOe2ptIfbdQWb/k00rZQZEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CiCgceHy; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CiCgceHy"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5ebc27fdc30so1345324eaf.2
        for <iwd@lists.linux.dev>; Tue, 22 Oct 2024 11:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729623178; x=1730227978; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3BjOVBPf1SsStd2P0UIVGS7adr7hxBdm8vx5A4JevCs=;
        b=CiCgceHym88I8OxY+wm9GEBBfQpcRL6DEVCfP9hNOr+qZ7U6/JP5AKr4LUGKz1w3Rl
         3o7ekN5KYvPV7nUBM2VLUOPDQ10ksQ7y+Tj1507JW6uiRq7O3TrEN2uHww6k5qS5LFdT
         Xzm4mRodGcqZZun16FnLaN+7EMgzRFac4sNfznVcMiBbQrpJkiGlygWKnGXTvb75Lggp
         6mi263cbzb7w1HKZoLB0l65tBVeX24TLEYm2LT0Pus0lPB20KwKWFQd0XQuY09ntDjVA
         RBTnK0azSgQcOaAayldvR9weJZ2NP9Mma8G21I+2tbG66NzMqa4038t+M8VUhPbjh/OE
         u1QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729623178; x=1730227978;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3BjOVBPf1SsStd2P0UIVGS7adr7hxBdm8vx5A4JevCs=;
        b=Cgy8Pbyu/4bMrf7c3ndojQ98iBCtVECzLWkWtk08JfufsBuy9FE05IAhJKEnKGjTGm
         DOOv2NOWJKbp7kHJSwPHW6l6J2JqCoY2PbRQ9vRDBS006ONVDxtGKHa9xpLfMfVahQoy
         Ev+DI89BGBgV89oirjA80mqHdBmr/p42OvSeyChj+58Q59/yEWIvD3re3g7KeIzdDIic
         NBHD4idRJ7fC9qNN3txcKGNKXS8HOHjDNDCtJcti2CHh0bI7dIIjAagQj/I8JL96/Xeb
         zFq1snPPBzwVMIKDWUd9h+fEAzUzXMvqP3n3Cet8oEVTRooEruB4TaU/R0XunWwmMmAZ
         8FEA==
X-Gm-Message-State: AOJu0Yw9O/GR4E5IPmf7eyyw/uWDWtWWuw3gdoCcB8gNMdR/AowgSdxG
	8LLbuQxM+LIMH9qyzt0R2xrxVuEuKG9Pi3+8x3e7yMvGLKdLBUrn
X-Google-Smtp-Source: AGHT+IGk4PcjcX5q9PPRYAIkhPw3vkE1XDSbPLwq8N2IBs33tpqk1SE62X4Vgg/v6KOkelduAw5SMQ==
X-Received: by 2002:a05:6820:160d:b0:5e7:c8d9:9606 with SMTP id 006d021491bc7-5ebee301405mr59482eaf.0.1729623177814;
        Tue, 22 Oct 2024 11:52:57 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-5ebb79d8d62sm1454770eaf.3.2024.10.22.11.52.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 11:52:57 -0700 (PDT)
Message-ID: <61e4a771-6dd2-442c-a2c2-0f544cc13cd0@gmail.com>
Date: Tue, 22 Oct 2024 13:52:56 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: IWD 1.27 with brcmfmac not working for roaming
To: James Prestwood <prestwoj@gmail.com>,
 Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: iwd@lists.linux.dev, KeithG <ys3al35l@gmail.com>,
 Martin Petzold <martin.petzold@tavla.de>
References: <a99e0ef1-8f97-4c1d-9aa5-5a07c87782a5@tavla.de>
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
 <2236075a-8239-4f1a-b878-adfd281f3dbb@tavla.de>
 <f1f2b4cc-367b-43df-a637-b380d979e11d@gmail.com>
 <6170a2a5-dc7d-4182-8b83-1b43b93c4f46@tavla.de>
 <06e10782-0c31-4cdd-bd2b-31d1daec03d5@gmail.com>
 <b3b58b08-da06-4485-a980-edcc42d2453c@gmail.com>
 <68a6c65a-0c53-4679-aa93-8cd9eb66228d@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <68a6c65a-0c53-4679-aa93-8cd9eb66228d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

> For an explicit option what about the transition disable stuff? I know you set 
> those options based on AP capabilities IIRC, but could we allow a profile to set 
> those manually? It appears that is checked for in network_can_connect_bss() but 
> I need to refresh myself on how that all works.

Transition Disable disables Open and mandates OWE, not really helpful here.  We 
can put this into driver quirks for now I suppose.

Regards,
-Denis
