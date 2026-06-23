Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E8613790B
	for <iwd@lists.linux.dev>; Tue, 23 Jun 2026 02:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782181096; cv=pass; b=l+/YxuMxez6WQhCovoVqnk64wA6HiYyU1zgIuN1vACXYSw3VLXnFNlGy+Px1/GeffpqngvwDs1l2iK6a5CZSl2h3yZyCNiVwaEvq9Nev0OSNN3IG8725KcdgBHPbWcyGnkdYhW0/w3TSxI4oauuG7sd/1oHTNPJpGTEDZNTA/oQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782181096; c=relaxed/simple;
	bh=Z/LBg/H9QVCGwVTtw1MuNQkfaA1dMS9U+1rPWfEmMVw=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=KtvIaUSo7Nl+V1dXc8b83LaF1rq82dWSpxkwVzGPSR4Wi8X8w7O1e/xBA3ItLaQqNWC8IJLmk3N6+dElrwokrYNb9jHSCzD0Skhus9MMshOkpLe8omxSukY01QAMl3EY/PMYTbsPkocjdtNdrm38WM247Q2ttQMGssclUNcUZBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=vignesh.raman@collabora.com header.b=MBPoqLta; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=vignesh.raman@collabora.com header.b="MBPoqLta"
ARC-Seal: i=1; a=rsa-sha256; t=1782181093; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PYB/0eZj9IIwxO1DRZXgcqbY6V+jbzWDzztV4MUiqapXY2nxT/qDG3CGlsFic3s5//Lfpy+vN8vZTBneNlH9qgFth88rNRcPfJMsg3Tr6evo80+xIAH5Y+DkMkqgeMDjxER/ffGR57nDHq3Yk9OEcfYaq1RBJOZnsdl1xFvka88=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1782181093; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=JCMZd1EB1dl1Zyd3x7JCTKmuzI5Bk//X2yhEneNbyi8=; 
	b=RFR62v9Xe2Z0heszMepBzrRBpaVJ2JUSNVSsJOOA6wgTocakX52yTKkcVyVd3QgSyPXUH0mFVWPrlHsVyp/gGbl0Jt0BpLPQGVmwW8bp0LGt93rEV8uFQ8UYBSopaRQIvZl0HHcWAUatMQAf5hVzMPHneRS1sRECf3sl43qUpjk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=vignesh.raman@collabora.com;
	dmarc=pass header.from=<vignesh.raman@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782181093;
	s=zohomail; d=collabora.com; i=vignesh.raman@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:To:To:From:From:Subject:Subject:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=JCMZd1EB1dl1Zyd3x7JCTKmuzI5Bk//X2yhEneNbyi8=;
	b=MBPoqLtaYB2x1DZia/UJTnnyL29MtEVL0ulq70qVhor2epyTJtB9Ig48UL7NfUnX
	eU1RxNYa8JnTt0KKWu6H38TjlXSYSw15lGMc4Ob409odu4aEqcEZ/erX7HuD6V5QXyr
	fMIFYu6+FEoJkS5d648hq0/xvbxyMX9/UROeO5Gc=
Received: by mx.zohomail.com with SMTPS id 1782181091176462.45307741608576;
	Mon, 22 Jun 2026 19:18:11 -0700 (PDT)
Message-ID: <b72269a6-2994-4f1c-83a2-ed8a40d6b9cc@collabora.com>
Date: Tue, 23 Jun 2026 07:48:07 +0530
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: iwd@lists.linux.dev
From: Vignesh Raman <vignesh.raman@collabora.com>
Subject: iwd fails to connect to hidden SSID
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Hi,

iwd (version: 3.9) fails to connect to a hidden SSID both standalone and 
when used as the wifi backend for NetworkManager. The same AP connects 
successfully using wpa_supplicant. This issue was reproduced in steamdeck.

More details in,
https://gitlab.freedesktop.org/NetworkManager/NetworkManager/-/work_items/1013

Steps (without NetworkManager):
(deck@steamdeck ~)$ sudo systemctl stop NetworkManager
(deck@steamdeck ~)$ systemctl is-active NetworkManager
inactive
(deck@steamdeck ~)$ iwctl device wlan0 set-property Powered on
(deck@steamdeck ~)$ iwctl device list
                                     Devices 

--------------------------------------------------------------------------------
   Name                  Address               Powered     Adapter 
Mode
--------------------------------------------------------------------------------
   wlan0                 b0:0c:9d:95:46:37     on          phy0 
station

(deck@steamdeck ~)$ iwctl station wlan0 disconnect
(deck@steamdeck ~)$ iwctl known-networks list
                                  Known Networks 

--------------------------------------------------------------------------------
   Name                              Security     Hidden     Last 
connected
--------------------------------------------------------------------------------

(deck@steamdeck ~)$ iwctl station wlan0 show
                                  Station: wlan0 

--------------------------------------------------------------------------------
   Settable  Property              Value 

--------------------------------------------------------------------------------
             Scanning              no 

             State                 disconnected 


(deck@steamdeck ~)$ iwctl station wlan0 scan
(deck@steamdeck ~)$ iwctl station wlan0 get-networks
                                Available networks 

--------------------------------------------------------------------------------
       Network name                      Security            Signal
--------------------------------------------------------------------------------
       Vicky_Asus_5G                     psk                 ****
       Vicky_Asus                        psk                 ****

(deck@steamdeck ~)$ iwctl --passphrase 'xxxx' station wlan0 
connect-hidden Vicky_Jio
Object not found

Logs:

Without NM:

```
Jun 04 07:52:01.302680 steamdeck iwd[1191]: 
src/station.c:station_add_seen_bss() BSS has hidden SSID
Jun 04 07:52:02.128478 steamdeck iwd[1191]: 
src/station.c:station_add_seen_bss() BSS has hidden SSID
Jun 04 07:52:02.132183 steamdeck iwd[1191]: 
src/scan.c:scan_request_triggered() Active scan triggered for wdev 2
Jun 04 07:52:05.935535 steamdeck iwd[1191]: 
src/station.c:station_add_seen_bss() BSS has hidden SSID
Jun 04 16:16:57.950590 steamdeck iwd[1235]: 
src/station.c:station_dbus_connect_hidden_network()
Jun 04 16:16:57.971723 steamdeck iwd[1235]: 
src/scan.c:scan_request_triggered() Active scan triggered for wdev 2
Jun 04 16:16:57.971723 steamdeck iwd[1235]: 
src/station.c:station_hidden_network_scan_triggered()
Jun 04 16:17:01.770657 steamdeck iwd[1235]: src/scan.c:scan_notify() 
Scan notification New Scan Results(34)
Jun 04 16:17:01.771150 steamdeck iwd[1235]: 
src/station.c:station_hidden_network_scan_results()
Jun 04 16:17:01.771150 steamdeck iwd[1235]: 
src/wiphy.c:wiphy_radio_work_done() Work item 9 done
```

With NM (iwd backend):

```
Jun 04 07:52:02.298619 steamdeck NetworkManager[1184]: <info>  device 
(wlan0): Activation: starting connection 'Vicky_Jio'
Jun 04 07:52:02.299870 steamdeck NetworkManager[1184]: <info>  device 
(wlan0): state change: prepare -> failed (reason 'none', managed-type: 
'full')
Jun 04 07:52:02.300280 steamdeck NetworkManager[1184]: <warn>  device 
(wlan0): Activation: failed for connection 'Vicky_Jio'
Jun 04 07:52:04.307425 steamdeck NetworkManager[1184]: <info>  device 
(wlan0): Activation: starting connection 'Vicky_Jio'
Jun 04 07:52:04.308025 steamdeck NetworkManager[1184]: <info>  device 
(wlan0): state change: prepare -> failed (reason 'none', managed-type: 
'full')
Jun 04 07:52:04.308389 steamdeck NetworkManager[1184]: <warn>  device 
(wlan0): Activation: failed for connection 'Vicky_Jio'
...
Jun 04 07:52:08.325069 steamdeck NetworkManager[1184]: <debug> policy: 
autoconnect: connection[...] (Vicky_Jio): failed to autoconnect; 0 tries 
left
```

The same AP connects successfully with wpa_supplicant as the wifi backend.

Regards,
Vignesh
