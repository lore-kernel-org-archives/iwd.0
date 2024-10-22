Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1231A302E
	for <iwd@lists.linux.dev>; Tue, 22 Oct 2024 15:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729610766; cv=none; b=M5uFXPUEAWEERJ/J7snw/tjgEslLECkdNiEHUNCR/qm2JKXCSBNshs+OFVz+dCRosM0CUP+e4zp9ryBcYay4YrwkSwudLEXe1fjcXCUhqg1KM1Gx9q+3Ekr5lz20bq8z0UZuvKhDNcFAZkPcNj3Rz9klFGx+kl4y2q5/wfB0QTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729610766; c=relaxed/simple;
	bh=8JC3RVuAkUFflWgoTxERRXLUYwqqdOeUiKGnb4M4Ffc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dzsaqAReEmb9siwpWe7Ge8xUEj3ljwq6l2Ule+VhA6RnHR6AGgQZXt9Ip+27O1G3DzOUSNB1KK7uF/BQEpl2ewO+jpmeqLYWJ8vpEZEt3kxQPmumxirH51ldeMGgYOHdOS5cYbaHJjXaFkM1F/sOA82DCZk2fm++PxFBa0FURy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZrBYpD5O; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrBYpD5O"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5ebbfcab9f4so1394089eaf.2
        for <iwd@lists.linux.dev>; Tue, 22 Oct 2024 08:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729610764; x=1730215564; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TE9BpFkKjvg0h4tfY/LTP812IxpjJEbqQkbCxiQWQXg=;
        b=ZrBYpD5OpE1JqMQBikD5No1Z5fy+q4XePyOS5n+aQfrDc+kNGacTL8pj5uvCb/H5nb
         f6zl7AjW08wTcfdEhYmotiq3KkJgpf5iF33cKN15/MrSHzBlbJ8Cz60n2QF1yeLuUKpc
         5zHTrYLm4tVyWzEj9hcPKvvUMifimjSVeJqkrHMjJaxKX1aZLrnFUQikTD6mpzwmqc2V
         qPY7f1vwJUmvnMx+REt6X7FA/+/g3LIPaTCb7fyRvgogRPZRkRMCU/X27jLdmWQygnEa
         DxF6aDpKty2XmAmiHlR75AJ+RBPNFJhbzu98INH+0sbRQ1QlMoofuNnFvSznfkwmY7Yv
         SQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729610764; x=1730215564;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TE9BpFkKjvg0h4tfY/LTP812IxpjJEbqQkbCxiQWQXg=;
        b=S4mZX7sMN19XviW3yMG51GprPv4iF8aoT0vZInYpDn4kAd8Y55fWWs4RamR72rL7Je
         rfSPZJGBvSbWOJiaScamLCgnRsLpNYd9pDatv6vcxf6XrpBS6Z/vVONACSEvZVNIZFZb
         WOt2hoEIH9oQzYkWh2B/+xZNSMIS6/FssO7LhUkBgaAqzj8NtNK6rHS6xafS+sDaduB8
         F6I/cxHEueYCPlyuZlEfi/5HkqMzSMig8gxbdjU+ekvs9MOrBSBlMNk/oAN9KocMWSHP
         L9NlLFL2JF48fbMztlPTEc+XvRnKY573hWpHEH7vRo35XKdPDWXndjVcJHrXbAmJfehg
         cjew==
X-Forwarded-Encrypted: i=1; AJvYcCW7hF5ZbgH6qrjfEzjQBZgd8y5sDXMExjATEZgy1FwU9yJwcRyCP3CX/tCkANDRFcwS0VA=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywr/ngp7r7DsSyMeUczzggbLhu64dHcIo6k9h07U+LH3U5SdKrA
	2jfuca+q+MzUkoPzOgrvH1e0qxjtWDe/SURURwY/S3VQVnI7F0wX
X-Google-Smtp-Source: AGHT+IF7aPePbM76Uln2ZTemQ9KwWagdckcNTLniQOxA1CKhrg/q3kykQhxOWOnpSj5oGjqTiLWbcg==
X-Received: by 2002:a05:6820:60e:b0:5e1:ea03:9286 with SMTP id 006d021491bc7-5ebda736279mr2387821eaf.6.1729610764472;
        Tue, 22 Oct 2024 08:26:04 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-5ebbd4c0aadsm1213168eaf.38.2024.10.22.08.26.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 08:26:04 -0700 (PDT)
Message-ID: <e5f30105-bf69-46f3-99aa-498d3f579c06@gmail.com>
Date: Tue, 22 Oct 2024 10:26:03 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: IWD 1.27 with brcmfmac not working for roaming
To: Jeremy Blum <jeremy@shapertools.com>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,
 James Prestwood <prestwoj@gmail.com>,
 Martin Petzold <martin.petzold@tavla.de>, iwd@lists.linux.dev
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
 <CAE+F7TGrbFG3A2KK1TZkwfiV6mi5p78_THi0w0nTC5OT0Q9Edw@mail.gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CAE+F7TGrbFG3A2KK1TZkwfiV6mi5p78_THi0w0nTC5OT0Q9Edw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

H Jeremy,

On 10/21/24 2:08 PM, Jeremy Blum wrote:
> Could try the SolidRun i.MX8M Mini SOM + Eval kit. It uses a 1MW
> module (same as the Pi, and based on the CYW43455)
> https://www.solid-run.com/embedded-industrial-iot/nxp-i-mx8-family/imx8m-mini-som/#evaluation-kits
> 

And this runs an upstream kernel?

Regards,
-Denis

