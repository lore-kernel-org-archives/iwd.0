Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1523A7826
	for <iwd@lists.linux.dev>; Thu,  2 Jul 2026 19:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783022321; cv=none; b=gWj55HCFpvAKqJ8ZHx0BND2HotzGgQPU2b88v8wRqErh+D7VtT0R6tFsT/OBNEq2tSlccVAptryfVkPraV7e8qf3iLje0m5BT8Slfm+0ahbQ3KGhSAEt/cEr4PU+U7Kj84eXD5wT2ItkIbwA9+gj+79N9fhQnRVQemh7BJt4ByI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783022321; c=relaxed/simple;
	bh=nxvAxXxKBu/Ejj/pxqIbWMFNdcZW37GSNdUno+5goVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hdY8V+bocUvZ6PDNDzRXTl0e8ecxiC5iEKaNG50WVgkmFqLVUsBFelCee+nJGSIbqPvuf2EwMy8YZhHZcJLxXA3TcVYHPrgSAl8H1EW6xvhFPcFzBPvzIhFKkjc6/+1xYu/qLFH1bk+1sZMzclpRxoPzCaXxY7ctmu2EnS1eZEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IwJytN5F; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwJytN5F"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6a1160a2c42so1364293eaf.0
        for <iwd@lists.linux.dev>; Thu, 02 Jul 2026 12:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783022317; x=1783627117; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bDRqLILMFslI/v0TBHOkq8JDJ8TVK2lj8TmegEN5nlY=;
        b=IwJytN5FlUSMvJFabwW3QORXE58cHHrIkKcGw/Riz6PsLslO/dbphJq864nTTSUhC2
         sEc9OeOIPOWPPeiK7JvcczhJ12EoomvXOeV5IzFyrrRPhMWbJXFquG9EWEx97lrn+PLo
         +qB4/n+Na+biWkRx+CykatRyhBR+BNl/2heqwSEnqXvAdSQ4NSqyoaIeJHzKzvZsLONI
         pWyu1m/rK/lXXmVFTktPPCyNjn5jtM75tTFBPyZHwPCLYRa2QbuxPK8TldK+p+iO4gD3
         Pp6Kihi8RXr/q1HfiEAY4HKUWgCwrgEBcKhAS+peblBlPi79AtZ/+QlKnmH1mEGZL9TY
         ehbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783022317; x=1783627117;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bDRqLILMFslI/v0TBHOkq8JDJ8TVK2lj8TmegEN5nlY=;
        b=qDpmJJ1ERfqF1ckNChf78z98swRNKqQy23BtEU1HeKe6aRqAVFmI47YtUR0TNlRPyw
         VenauHTXxIuRcv/bfFNB/wa5o7r6y350evQtn1Gfu5d09/1knrShd4yHTXZ+P/aQMEJM
         Vh6SJsIh+7VCSegeVc9w0gAeb4f7BTygaJ9m/efDneyf63oRYMlJmiCOOsJYKRESI5Aq
         rOUPqXRyF/nhYhJQ32hxufXSlo2a7b0flr7WRQqhrUmZpF7R5YSBXyB3OJl06G6Q+mjQ
         kzjTF68FpepiC08eaD0/7KeoBkIvMzx1YeP7ILbBTXMaF+eszo8Uty/zaMJBYz169gg+
         YfIg==
X-Forwarded-Encrypted: i=1; AFNElJ+NzlEmvU3MY70SM3OzYwncvVFbUHh9eIBbEGcFsWhZJe87gHkVW4VwjD4XxdHaCrPcz5A=@lists.linux.dev
X-Gm-Message-State: AOJu0YziVOopBoCT0L7GVrILmSQEbm/o9VTg5PTK4UuA/AI6bpMbXNG5
	J/+5XdJfkOa/cB2LJ77j/bTZhcmQ8vRz18/RggGGBbwD0zLW/nXzDkxsxDQGZg==
X-Gm-Gg: AfdE7clDCpa8n9m+vecwrgQLo8NZn7+uL/R3zMGBpHOerUqwWdPSAzNyEWz5tdJpPCt
	JiNh0U0Qfya55bfHhq+pXHCXR5omA+pNjJjupYiFaLs4mqEMNOLtU8vZj24ITpTb2LpBTyZ/x7W
	t6U0n1UG5I5WeR1wnrCnaZ6o/fY3oVsfhRBDwSuwiLvS+lf4acz5Fis7wZBZmSp6/q7/9XvO01P
	m+7Tocis9BA5zyuEG6DXsiwkYabNZuTEF0qYwQf2Yvj6/e7Askuw3Kl/23HJ1R+J23Gi/kz00N9
	4aymFIzxaRFT6rvq4RYBkzVuX7EEbtzhCSFKA+u4uMkseOvwGEaFvKZVR6M2gSLF8W7ifqCDUaQ
	74619Kath+Sx+KEIm3YP9kqAs5sZ7o1WX9I5rVHn8t8IBss8YUcIrqrnMJ8b2om7j9/Ire22vtX
	TljZspb2WZGcbsgwFurAL/FW9yR+avwsq96oCn5f8Q94GRRfN9
X-Received: by 2002:a05:6820:16a2:b0:6a1:5103:5ee5 with SMTP id 006d021491bc7-6a309a76ed0mr4716755eaf.28.1783022316617;
        Thu, 02 Jul 2026 12:58:36 -0700 (PDT)
Received: from [10.113.169.105] ([38.76.119.195])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44cbe8d9a7asm3391206fac.6.2026.07.02.12.58.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 12:58:34 -0700 (PDT)
Message-ID: <566a83a9-6d67-4432-884e-c7c7c27c37f9@gmail.com>
Date: Thu, 2 Jul 2026 12:58:31 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] knownnetwroks: add DisableRoamingScan option
To: Matthew Leach <matthew.leach@collabora.com>, iwd@lists.linux.dev
References: <20260702-knownnetworks-disable-roaming-option-v1-1-6b02b89d95f2@collabora.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20260702-knownnetworks-disable-roaming-option-v1-1-6b02b89d95f2@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Matthew,

On 7/2/26 12:42 PM, Matthew Leach wrote:

typo in the title: knownnetwroks -> knownnetworks
> Add a new knownnetworks option: DisableRoamingScan. When set, and the
> STA is connected to that network, roaming scans are disabled.
>
> ---
>   src/iwd.network.rst | 4 ++++
>   src/knownnetworks.c | 5 +++++
>   src/knownnetworks.h | 2 ++
>   src/station.c       | 8 ++++++++
>   4 files changed, 19 insertions(+)
>
> diff --git a/src/iwd.network.rst b/src/iwd.network.rst
> index 892c6eb8..7c50e76f 100644
> --- a/src/iwd.network.rst
> +++ b/src/iwd.network.rst
> @@ -181,6 +181,10 @@ The group ``[Settings]`` contains general settings.
>          (WPA3 and OWE) if set true. If unset IWD will learn the capabilities of
>          the network based on its initial association and retain that setting for
>          the duration of its process lifetime.
> +   * - DisableRoamingScan
> +     - Values: true, **false**
> +
> +       Whether roaming scans are inhibited while connected to this network.
>   
>   Network Authentication Settings
>   -------------------------------

Denis might want the above split into a second patch, but you can wait 
for his feedback on that.

Other than that LGTM.

> diff --git a/src/knownnetworks.c b/src/knownnetworks.c
> index 886f8145..c6d141a0 100644
> --- a/src/knownnetworks.c
> +++ b/src/knownnetworks.c
> @@ -135,6 +135,11 @@ void __network_config_parse(const struct l_settings *settings,
>   					NET_USE_DEFAULT_ECC_GROUP);
>   	} else
>   		config->ecc_group = KNOWN_NETWORK_ECC_GROUP_AUTO;
> +
> +	if (!l_settings_get_bool(settings, NET_DISABLE_ROAMING_SCAN, &b))
> +		b = false;
> +
> +	config->disable_roaming_scan = b;
>   }
>   
>   void __network_info_init(struct network_info *info,
> diff --git a/src/knownnetworks.h b/src/knownnetworks.h
> index a117ded5..c2fce4c2 100644
> --- a/src/knownnetworks.h
> +++ b/src/knownnetworks.h
> @@ -30,6 +30,7 @@
>   #define NET_TRANSITION_DISABLE SETTINGS, "TransitionDisable"
>   #define NET_TRANSITION_DISABLE_MODES SETTINGS, "DisabledTransitionModes"
>   #define NET_USE_DEFAULT_ECC_GROUP SETTINGS, "UseDefaultEccGroup"
> +#define NET_DISABLE_ROAMING_SCAN SETTINGS, "DisableRoamingScan"
>   
>   enum security;
>   struct scan_freq_set;
> @@ -78,6 +79,7 @@ struct network_config {
>   	bool is_autoconnectable:1;
>   	bool override_addr:1;
>   	bool always_random_addr:1;
> +	bool disable_roaming_scan:1;
>   	uint8_t sta_addr[6];
>   	bool have_transition_disable : 1;
>   	uint8_t transition_disable;
> diff --git a/src/station.c b/src/station.c
> index 8fcf8c70..b94236fe 100644
> --- a/src/station.c
> +++ b/src/station.c
> @@ -3198,6 +3198,14 @@ static bool station_cannot_roam(struct station *station)
>   	if (wiphy_supports_firmware_roam(station->wiphy))
>   		return true;
>   
> +	if (station->connected_network) {
> +		const struct network_info *info =
> +		    network_get_info(station->connected_network);
> +
> +		if (info && info->config.disable_roaming_scan)
> +			return true;
> +	}
> +
>   	if (!l_settings_get_bool(config, "Scan", "DisableRoamingScan",
>   								&disabled))
>   		disabled = false;
>
> ---
> base-commit: d003d0e593323b3de427f01284ede81ba61e9dcc
> change-id: 20260702-knownnetworks-disable-roaming-option-6c83c27adb56
>
> Best regards,
> --
> Matt
>
>
