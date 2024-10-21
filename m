Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12571FAC31
	for <iwd@lists.linux.dev>; Mon, 21 Oct 2024 18:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729536941; cv=none; b=Jq4zx5i0WP2m+iPPi4a/1rVDlcmA/ieDgXi1l/IbT7Un1GtT9oscopUt9XgusJbSHYi70vNkDN3z9GJgmvV0y21AG911rbCnSD+OPVwcJkqZY3wNwc3FwZoPZe0F2GwSS+jslzwNTsuTEDcv/5/GwhbmrHXOf5sq03dprIb0HqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729536941; c=relaxed/simple;
	bh=reB6QHkuki3HendLUEDO2bc+C5oclIkfs6QitOOKgwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MFEYJaOo5sdCshjkYA8AQKKz1L6i4fqphndhlM311BaOrx2g/bmfaEHpinvtrmkvojL1XpbHJKgqhLcCXLHXRVcWdAK3jKB8VXi6WC158zNaq/cNKQ1UtcUsfPRbZHZ4QazSxM1zk33gO4OdPR6JmqTtMgmekuh2SYic0g3nvrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J94deIAI; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J94deIAI"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3e604425aa0so1342021b6e.0
        for <iwd@lists.linux.dev>; Mon, 21 Oct 2024 11:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729536939; x=1730141739; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TV2lPtZwVCYYf3DivxKWmkrDmIgTyjlOMZ7K4GADirU=;
        b=J94deIAIK8XVv2Rrn0x5pG8TO1xMkxdLUGdX/awoaDYwivJ4jpr+p1HpYQnKI8s7yn
         j1BZ03LJxOCPaZBiVsZQMA0wSZ8iXRa54WiShzRvEMXsQErbv9a5leDOPOv/RL6DQwKS
         DcN8YTUkxPlEQVQjJ+IN74o9e/dghg7xnLZ78uCiOP+hGYmCuEBMQ8VeCFBq+fZgcpYu
         L4z7wnbrjSa/M5vcEZKl8uim7UY026uZ+a1i8pS3/jAkvLI2lsYKDuPvOIEWmB9mOTX4
         32qp4JVultSDU1vyYQ+8UUE1dMF/hy4JNbfNxoNBJkRQGjQ25akrl5mA+AJJ/ocB/TKr
         OYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729536939; x=1730141739;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TV2lPtZwVCYYf3DivxKWmkrDmIgTyjlOMZ7K4GADirU=;
        b=pAqu1XBYn5sNmCqcUi0sCuFAAd44LecmQ4N06FD3ZosYvW6SEvQ4pOTm6zJbtcyYCL
         tGYp1B/+YhYeIjsuFERGAsVWxPTIO5jUyCsg0dgskzGhxXjS0HvfUfKx9pikoj4lnzdr
         yjU23dEX6SdaoPLvdAomCa6ISmPltHX360SLMSYxqzdkXAWlHW+J2JcRCBg1zFXaB9a7
         11DrC8UtX2uHd2bBVev2brW+4GIUBFzMGP+zsAM7y78wUf00BEKSXf2+lQmdPu1pMZgq
         l1/jcRw0UkDuntbD5Bru3h8nXkpyimBkajJe2pjb8UQMbgHPoRKU9BTKawzEN7m4Vm77
         8tnw==
X-Gm-Message-State: AOJu0Yw0/PoG7vwieEPpXGhUviGenpEmk76nlEsc2dUb9PJOG+sh/0s+
	XkIWBYa108EkPQxV7mPgdBJO7XXuXC5074fwZcv0V7lH2kNmmVwl373Apw==
X-Google-Smtp-Source: AGHT+IG7mYrndV2zDcVHHAr6cuS4uvCgoPq3WnmaSz6QYp2TOG/mkyA02zxSRmn7sloh3dD7qDzYzw==
X-Received: by 2002:a05:6808:210c:b0:3e5:f9dc:dbee with SMTP id 5614622812f47-3e602cc5d3cmr10915147b6e.27.1729536939033;
        Mon, 21 Oct 2024 11:55:39 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-3e61034f060sm898918b6e.35.2024.10.21.11.55.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 11:55:38 -0700 (PDT)
Message-ID: <db8b9660-3e68-4223-aa3e-e3d6a7d18906@gmail.com>
Date: Mon, 21 Oct 2024 13:55:37 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: IWD 1.27 with brcmfmac not working for roaming
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
 James Prestwood <prestwoj@gmail.com>,
 Martin Petzold <martin.petzold@tavla.de>
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
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <c57706f6-2d5c-4e73-bc42-e2b7e4239a78@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Arend,
> 
> I have never seen any mention of OWE either. Regarding CMD_EXTERNAL_AUTH support 
> I recently posted patches on linux-wireless list as RFT. There has been zero 
> feedback and so I assume also zero interest. In order to use CMD_EXTERNAL_AUTH 
> the firmware needs to advertise "sae_ext" in fwcap debugfs file. So if Martin 
> can check that, ie:

Any suggestions for hardware I can buy that I can test the upstream kernel on 
easily?  I don't have any brcmfmac devices besides the RPI5 and that uses a 
totally different kernel.

Regards,
-Denis
