Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889FBE56A
	for <iwd@lists.linux.dev>; Wed, 23 Oct 2024 15:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729696273; cv=none; b=Wv9HkCHLya/YuWfaVzS5BVrbM4f6AcMp9n91Uh/b50+jdo4byUqSmKTvnos9ayD0ZkroVSFGb6w+L7j80LGe6buRkITxjy+tBguDgZb6XRJ/VmhsuZo9pDIILogYocQ2pXrQPpuyjXWg2usGfNK8CceX9NrZpMC8RsfzWzPrqlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729696273; c=relaxed/simple;
	bh=7RloDtS7VsBmflDpFCPtuFiUL+WYu5wX7wD3DwGTvng=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=QtMdxdF8OGbLIntjzXI77CPaqRN/QyPj04lOILSxa4GeuuKUUQhhqm0coeejb8ONZoCD7Agk1JwO5xcMe1nNBAlCtmKgG00DKFw937Oj4WR3gqhOba/ccFjjHY57HvdqlEFULUPlCy0iIeNLpLpWf08lVWhgejj/+8KKf78Hm6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=T+3BmeeQ; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="T+3BmeeQ"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b15467f383so444815185a.3
        for <iwd@lists.linux.dev>; Wed, 23 Oct 2024 08:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1729696270; x=1730301070; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZFq3rSgPk36fKHtL6JnNAxtroOcy/+JV+R4FMKCbgfE=;
        b=T+3BmeeQTVtLxRdIUEWrDFV81cm5h14Ni28Gsffyru2Jv/FE61G16wMB9hKuJEC9U2
         skYiUgUi4OCOtjDP9lRGcP4ZSJNPtA753iKOnqZJ+w4njWkrS/PYIW1pAPbV23/aHf1m
         ydO2dOnbol1o6pUnKbqkSI3Z2T4k0Z6WqiT38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729696270; x=1730301070;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFq3rSgPk36fKHtL6JnNAxtroOcy/+JV+R4FMKCbgfE=;
        b=DTu0jbWaNVLCfvHrxGKn8SOFakSP5zJRwmCrclkQozt3UMFkS98Qdeh/C1eEghSVY/
         N28PzRQJ0vnxNAVAD6OKvXF0QiUtkqlI3EU/xu9DpANZlwN38uGX+hbkXGVq6V/0chFA
         hFiUcm6jPj1YysojtyaNg216DEdxMbBHfBN4JF7UfDxvwt06veoJT3uv/IQEFUKCY8Hu
         VXla//08UJ+1zZJoFCd4+MgEmf2PCGqX/kAEcnez+F2g4Qat/BLEgR2wsnH0Xf/53sWd
         fW10j5im9B2jhj/B9+N98WQqzeeQBv9/BTj+Do5lOqK0wfMM6Phr+qskQ0npS/StxWXe
         JC9Q==
X-Gm-Message-State: AOJu0Yx/nO820aZLZmk2DnkofPfg5SmzmhdLG0dibmRL1z/RoknCs+ww
	5GN+gpa9Z00U9INjeRkeE8r2MjooCZ0O+d7X5lfzTcAg//qhYyAikr/k6DjqNA==
X-Google-Smtp-Source: AGHT+IG7i30BctpU04X9fuhnk/UH3XKEGFePx1MWKtv/DN2Qqkoi0o0yggXCTx/nZBGQgD1qiXNKIw==
X-Received: by 2002:a05:620a:1a92:b0:7b1:481f:b8b7 with SMTP id af79cd13be357-7b17e5b2d7cmr379646185a.43.1729696270349;
        Wed, 23 Oct 2024 08:11:10 -0700 (PDT)
Received: from [10.229.40.71] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1659e6022sm394008885a.47.2024.10.23.08.11.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 08:11:09 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Martin Petzold <martin.petzold@tavla.de>, James Prestwood <prestwoj@gmail.com>
CC: <iwd@lists.linux.dev>, Denis Kenzior <denkenz@gmail.com>
Date: Wed, 23 Oct 2024 17:11:06 +0200
Message-ID: <192b9ee7710.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <e5626359-2b7c-4161-9aa7-7fd7133ec390@tavla.de>
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
 <e5626359-2b7c-4161-9aa7-7fd7133ec390@tavla.de>
User-Agent: AquaMail/1.53.0 (build: 105300523)
Subject: Re: IWD 1.27 with brcmfmac not working for roaming
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On October 23, 2024 2:02:20 PM Martin Petzold <martin.petzold@tavla.de> wrote:

> Hi Arend and James

[...]

> -----
>
> @Arend: Here the requested output (debugging enabled; PATCHES ALREADY
> APPLIED!).
>
> -----
>
> tavla@tavla:~$ sudo cat /sys/kernel/debug/ieee80211/phy0/fwcap
> ap
> sta
> wme
> 802.11d
> 802.11h
> rm
> cqa
> ccx
> cac
> dualband
> ampdu
> ampdu_tx
> ampdu_rx
> amsdurx
> amsdutx
> radio_pwrsave
> btamp
> p2p
> proptxstatus
> mchan
> vht-prop-rates
> p2po
> anqpo
> txpwrcache
> stbc-tx
> stbc-rx-1ss

So there is no sae_ext. Also no sae or idsup so that rules out WPA3 I would 
say. With this firmware at least.


