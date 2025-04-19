# Interval Resonance Analysis (InRA)
![Logo](/images/InRA_logo_oficial.png)  

InRA GUI consists of .m files developed under MATLAB R2023b. 

| Version | Matlab Compatibility  |            Oficial site                 |               Oficial email       | 
| :---:   |         :---:         |                 :---:                   |                   :---:           |
| 1.0     | R2020b <br> and later |  https://github.com/InRA-Software/InRA  | inrasoftware (at) gmail (dot) com |

> [!NOTE]
> **All the algorithms implemented in InRA have been specifically developed/modified for this tool based on literature and open-source functions.**
## Authors:
**Rosario del P. Castillo**
- Department of Instrumental Analysis, Faculty of Pharmacy, University of Concepción - Chile
- Laboratory of Biospectroscopy and Chemometrics (BioSpeQ), Biotechnology Center, University of Concepción - Chile
- email: rosariocastillo (at) udec (dot) cl

**David Montoya**
- Department of Physics, Faculty of Physics and Mathematics, University of Concepción - Chile
- Laboratory of Biospectroscopy and Chemometrics (BioSpeQ), Biotechnology Center, University of Concepción - Chile
- email: davmontoya (at) udec (dot) cl
  
**Cristian A. Fuentes**
- Department of Instrumental Analysis, Faculty of Pharmacy, University of Concepción - Chile
- Laboratory of Biospectroscopy and Chemometrics (BioSpeQ), Biotechnology Center, University of Concepción - Chile
- email: crisfuentes (at) udec (dot) cl

# ANALYTICAL WORKFLOW OF InRA
Before starting, make sure the file **InRA.m** is located in the same directory as the **scripts** and **modules** folders.
> [!IMPORTANT]
> ***To import a set of <sup>1</sup>1H NMR spectra into the current version of InRA (v1.0), the spectra must be previously phased, baseline-corrected, and referenced. Accepted file formats include .cv, .xlsx, and .xls. In the matrix array, the first column must contain the chemical shifts values (ppm), while the subsequent columns should include the intensity values for each sample).***

<details>

<summary> 1. PROCESSING </summary>

## 1. PROCESSING

<details>

<summary> 1.1 IMPORT A SET OF <sup>1</sup>H NMR SPECTRA </summary>

### 1.1 IMPORT A SET OF <sup>1</sup>H NMR SPECTRA
- In the MATLAB workspace, launch the software by typing InRA in the Command Window.  
- Click the **Import NMR Spectra** button and select the file containing the set of <sup>1</sup>H NMR spectra. Once loaded, the spectra will be displayed in the first plot using the **Overlay** mode. Additionally, the matrix size (e.g., 50 x 66945) will be shown.  
- The first module, **Spectra Display Modes**, will now be enabled. This module offers three general visualization modes: **Overlay (default)**, **Average**, or **Median**.  
- A list labeled **Set of Samples** allows for individual visualization of each <sup>1</sup>H NMR spectrum.  
- Specific samples can be excluded from the analysis if necessary by clicking on the **Exclude sample** button. (Sample list and matrix size will be updated automatically).  
- Once the <sup>1</sup>H NMR spectra have been reviewed, click the **Continue** button to proceed with the analysis.  
![Processing_1](/images/Processing_1.png)

</details>

<details>

<summary> 1.2 PROCESS A SET OF <sup>1</sup>H NMR SPECTRA </summary>

### 1.2 PROCESS A SET OF <sup>1</sup>H NMR SPECTRA
- The second module, **Processing options for <sup>1</sup>H NMR spectra** and a second plot titled **Processed <sup>1</sup>H NMR Spectra** will be activated. The latter plot will update progressively as processing steps are applied, while the first plot will remain unchanged to allow for a easy and direct comparison between the "raw" and "processed" spectra.  
- The first step involves defining an appropriate chemical shift range that includes the relevant resonance signals. Enter the lower and upper ppm values in the boxes labeled **Lower ppm** and **Higher ppm**, respectively. For example: **Lower ppm = 0.2 and Higher ppm = 9.6**.  
- By clicking the **View** button, vertical lines appear in the plot to indicate the selected spectral range.  
- To apply and reduce the spectral range, click the **Range** button.  
- The spectral matrix will be automatically adjusted according to the defined range, and the updated matrix size will be displayed immediately.  
![Processing_1](/images/Processing_2.png)
- Next, it is necessary to perform proper spectral alignment to correct any misalignments that could affect further analysis. InRA includes the ***icoshift*** algorithm for this purpose (https://doi.org/10.1016/j.jmr.2009.11.012).  
- To perform alignment, two main selection must be made. First, under the **Reference** functionality, an appropriate reference vector must be selected. Available options include: **Average**, **Median**, **Max (spectrum with the most intense features)**, or **Average2**. If the **Average2** option is selected – _which uses the average of the average multiplied by a specific value_ – a new window **Multiplier** will open. In this window, the **input multiplier value** must be entered.  
- Second, the alignment **mode** must be specified. Two modes are available: **whole** or **intervals**. The **whole** mode applies _icoshift_ to the entire spectral range, offering a straightforward and simplified approach.  
![Processing_1](/images/Processing_3.png)
- For a more refined alignment, the **intervals** mode should be selected. Upon selection, a new window titled **Icoshift: Intervals** will appear.  
- Intervals must be manually defined by specifying the **Lower ppm** and **Higher ppm** values and then clicking the **Add** button to include the interval. (Added intervals will appear in a numbered list).  
- To remove an interval, click the **Delete** button.  
- If any interval needs to be modified, enable the **Edit interval** checkbox. The latter will activate a slider bar that allows for adjustment of the ppm values.  
- Once all desired intervals have been added and configured, click **Continue** button to execute the alignment.
![Processing_1](/images/Processing_4.png)
- To remove residual signals (e.g., water after presturation), define the ppm range by entering values in the **Lower ppm** and **Higher ppm** options.
- By clicking the **View** button, the selected ppm range will be highlighted in the plot for visual inspection.
- Once the desired range has been confirmed, click the **Delete** button to remove the signal. The latter process can be repeated as many times as necessary.
![Processing_1](/images/Processing_5.png)
- The final step consists of spectra normalization. One of the available normalization options must be selected: **Norm-1 (total sum norm)** or **Norm-2 (Euclidean norm)**.
- If spectral dimensionality reduction is needed, the binning method can be applied. InRA includes the equidistant binning (equal size) method.
> **IMPORTANT:** ***To proceed with the subsequent analytical workflow, it is recommended not to apply binning, but a very small bucket width (e.g., 0.001) can be possible. The methodology implemented in InRA focuses on preserving relevant spectral information, i.e., signal shape and multiplicity, without loss of spectral resolution.***

- To perform bucketing, set the bucket size in the **Bucket Width** option and click the **Binning** button. Moreover, by clicking **Integration**, the bucket spectra will be integrated. To export the integrated bins click the **Export integrated Bins to .csv file**.  
> **IMPORTANT:** ***The latter option is recommended only when using InRA for processing purposes without continuing to the following steps.***

![Processing_1](/images/Processing_6.png)

</details>


<details>

<summary> 1.3 PREPARE A SET OF <sup>1</sup>H NMR SPECTRA FOR COMPARISON </summary>

### 1.3 PREPARE A SET OF <sup>1</sup>H NMR SPECTRA FOR COMPARISON
- An additional function, **Binning to Compare**, is available for generating a bucket matrix specifically for comparison via PCA at the end of the workflow. This matrix is internally referred to as **Bucket Spectra**, and it is saved along with the **Original Processed** matrix (i.e., the <sup>1</sup>H NMR spectra that has been range-selected, aligned, residual signal removed, and normalized before binning).
- To achieve the latter, define the bucket size under the **Bucket Width** section, then click the **Binning to Compare** button.
- A new window will open displaying the **Bucket Spectra**, and a confirmation message will indicate that the **Bucket Spectra** matrix and the **Original Processed** matrix have been stored internally.
> **IMPORTANT:** ***When using this option, any bucket size can be applied, as the resulting matrix is treated independently and is intended solely for comparison, without affecting subsequent analysis.***

![Processing_1](/images/Processing_7.png)
- Finally, to continue with the analysis, click the **Proceed to Interval Detection** button. If needed, the processed <sup>1</sup>H NMR spectra can be exported in .mat clicking the **Export Spectra to Workspace** or .csv format by clicking the **Export Spectra to .csv file**. 


</details>


</details>

##

<details>

<summary> 2. INTERVAL-BASED DETECTION </summary>

## 2. INTERVAL-BASED DETECTION

<details>

<summary> 2.1 ADJUST DETECTION PARAMETERS  </summary>

## 2.1 ADJUST DETECTION PARAMETERS 
- Before performing resonance signal detection, it is possible to adjust detection parameters to optimize the accuracy of the results. 
- To access these options, click the **Settings** button. A new window will open with the three internal parameters of the detection algorithm that can be modified: 
  - ***Detection Window (D)*** - Default: 0.01 ppm
  - ***Distance Consecutive Maxima (L)*** - Default: 0.03 ppm
  - ***Separation Distance (H)*** - Default: 0.005 ppm
- Once the desired values have been set, click the **Save** button to store the new settings. To revert to the default values, click the **Default Values** button and close the window.  
- In addition, the algorithm operates **independently** across three default spectral regions:
  - **0 - 3 ppm**
  - **3 - 6 ppm**
  - **6 - 10 ppm**
- If necessary, these spectral boundaries can be modified. 

> **IMPORTANT:** ***Only the 3 ppm and 6 ppm limits can be changed.*** 

- Click the **Change Bound** button, a new window will appear showing the current region boundary as a red line. 
- Adjust the value manually using the ppm slider. When finished, click **Apply Changes**, the new region settings will be saved, and the change in ppm (e.g., 3.1 - 6 ppm) will be displayed in the respective module. 
![Processing_1](/images/Interval-based_detection_1.png)

</details>

<details>

<summary> 2.2 PERFORM RESONANCE SIGNAL DETECTION  </summary>

## 2.2 PERFORM RESONANCE SIGNAL DETECTION
- To begin the signal detection process, a threshold value must be set in the **Threshold** section (e.g., 0.001). The threshold value can range between 0.001 and 0.7500. 
- Detection can be performed either independently for each spectral region or simultaneously across all regions: 
  - Independent detection:  
    To detect signals in a specific region, click the **Detect** button associated with that region. Once the signals are detected and the intervals are generated, they will be displayed on the spectral plot. An independent list will be created for each spectral region (R1, R2, and R3). Each list contains the numbered intervals, which can be browsed. The ppm boundaries of each interval will appear in the **Lower ppm** and **Higher ppm** sections. 
  - Simultaneous detection:  
    To detect signals across all spectral regions at once, define a threshold value for each region. Click the purple Detect button to perform detection. The generated intervals will appear on the plot with distinct color to distinguish their corresponding spectral regions. 

> **IMPORTANT:** ***Threshold values can be adjusted for each spectral region as many times as necessary until a suitable detection is achieved.***
 
![Processing_1](/images/Interval-based_detection_2.png)

</details>

<details>

<summary> 2.3 MODIFY SPECTRAL INTERVALS  </summary>

## 2.3 MODIFY SPECTRAL INTERVALS
- To ensure optimal results, intervals can be manually added, edited or removed as needed. 
- Click the **Zoom region** button to closely inspect a specific spectral region. To turn back, click the **General View** button. 
- For manually defined a new interval, enter the desired values in the **Lower ppm** and **Higher ppm** input sections (e.g., **Lower ppm = 1.846**, **Higher ppm = 1.960**). Click the **Add** button and the interval will be added and highlighted on the plot.

> **IMPORTANT:** ***The interval list (Detected Intervals) is automatically updated and re-ordered based on ppm values. For instance, if a detected interval originally labeled as "R1-Interval 3" spans from 1.50 to 1.68 ppm, and an interval from 1.22 to 1.38 ppm is manually add, the new interval will become "R1-Interval 3", and the previous one will be shifted to "R1-Interval 4" accordingly.***

- To edit an existing interval, select the interval from the list and click the **Edit** button and a new window will appear.
- Adjust the interval boundaries using the ppm slider. After the desired changes, click **Apply Changes** to save the update. 
- To delete an interval, select the interval from the list and click the **Delete** button. The interval will be removed from the list and the plot. 
- All manually added or deleted intervals are automatically tracked and can be viewed in the respective **Added** and **Deleted** modules associated with each spectral region.  
![Processing_1](/images/Interval-based_detection_3.png)  
- Finally, to continue with the analysis, click the **Proceed!** button. If needed, the detected intervals can be exported to the MATLAB workspace clicking the **Export Intervals** button. A new window labeled **Info** will appear, indicating that the intervals have been successfully exported as cell arrays (IntervalsRegion1, IntervalsRegion2, and IntervalsRegion3). In each cell array the first column contains the ppm values and the second column contains the corresponding intensity values.  
![Processing_1](/images/Interval-based_detection_4.png)

</details>



</details>

##

<details>

<summary> 3. RESONANCE INTEGRATION </summary>

## 3. RESONANCE INTEGRATION
![Processing_1](/images/Interval-based_detection_1.png)
![Processing_1](/images/Interval-based_detection_2.png)
![Processing_1](/images/Interval-based_detection_3.png)
![Processing_1](/images/Interval-based_detection_4.png)

</details>

##

<details>

<summary> 4. UNSUPERVISED ANALYSIS </summary>

## 4. UNSUPERVISED ANALYSIS
![Processing_1](/images/Interval-based_detection_1.png)
![Processing_1](/images/Interval-based_detection_2.png)
![Processing_1](/images/Interval-based_detection_3.png)
![Processing_1](/images/Interval-based_detection_4.png)

</details>
