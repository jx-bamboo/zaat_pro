import { Controller } from "@hotwired/stimulus"
import * as THREE from 'three'
import { GLTFLoader } from "https://cdn.jsdelivr.net/npm/three@0.162.0/examples/jsm/loaders/GLTFLoader.js"
import { OrbitControls } from "https://cdn.jsdelivr.net/npm/three@0.162.0/examples/jsm/controls/OrbitControls.js"

// Connects to data-controller="removals"
export default class extends Controller {
  scene;
  camera;
  renderer;
  cube;
  loader;

  connect() {
    const paramValue = this.data.get('orderid')
    const parentDiv = document.getElementById("three");


    this.scene = new THREE.Scene();
    // this.scene.background = new THREE.Color('#263238');
    // this.scene.background = new THREE.Color('#f0f2f5');
    this.scene.background = new THREE.Color('#212529');

    //创建一个平行光
    const directionalLight = new THREE.DirectionalLight(0xffffff, 2);
    directionalLight.position.set(0, 1, 0); // 设置光源位置，[0,1,0]从上到下
    this.scene.add(directionalLight);

    // 创建一个环境光
    const ambientLight = new THREE.AmbientLight(0xffffff); // 设置光照颜色
    ambientLight.intensity = 2; // 增加环境光的强度
    this.scene.add(ambientLight);
    // this.scene.position.setY(-1);
    
    this.camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
    this.renderer = new THREE.WebGLRenderer();
    this.renderer.setSize(window.innerWidth * 0.5, window.innerHeight * 0.5);
    // this.renderer.setSize(650, window.innerHeight * 0.5);
    
    this.controls = new OrbitControls(this.camera, this.renderer.domElement);
    this.controls.enableDamping = true; // 鼠标平滑控制旋转
    this.controls.update();
    
    parentDiv.appendChild(this.renderer.domElement);
    this.camera.position.z = 5;

    // ..........设置父级 div 的尺寸.........
    window.addEventListener('resize', () => {
        const width = parentDiv.clientWidth;
        const height = parentDiv.clientHeight;
        this.camera.aspect = width / height;
        this.camera.updateProjectionMatrix();
        this.renderer.setSize(width, height);
    });
    // .........设置父级 div 的尺寸..........
    this.animate();
    
    const mmodel = document.getElementById("mmodel")
    const loadingText = document.createElement('div');
    loadingText.innerText = 'Loading...';
    loadingText.classList.add('text-center', 'position-absolute', 'start-50', 'top-50', 'translate-middle', 'h1');
    mmodel.appendChild(loadingText);

    this.loader = new GLTFLoader();
    var imagePath = '';
    if (paramValue) {
      imagePath = '/order/' + paramValue + '/result.glb';
    } else {
      imagePath = '/three/eiffel.glb';
    }

    this.loader.load(imagePath, (gltf) => {
      this.scene.add(gltf.scene);
      // parentDiv.removeChild(loadingText);
      loadingText.classList.add("d-none");
    }, undefined, (error) => {
      console.error(error);
      // 加载出错时也移除加载动画
      // parentDiv.removeChild(loadingText);
      loadingText.classList.add("d-none");

    });

  }

  animate = () => {
    requestAnimationFrame(this.animate);
    // this.cube.rotation.x += 0.01;
    // this.cube.rotation.y += 0.01;
    this.renderer.render(this.scene, this.camera);
    this.controls.update();
  };
  
}

